require "openssl"
require "net/smtp"

Net::SMTP.class_eval do
  DEFAULT_AUTH_TYPE = :plain unless defined?(DEFAULT_AUTH_TYPE)
  private
  def do_start(helodomain, user, secret, authtype = DEFAULT_AUTH_TYPE)
    raise IOError, 'SMTP session already started' if @started
    if user or secret
      check_auth_method(authtype)
      check_auth_args(user, secret)
    end
    sock = timeout(@open_timeout) { TCPSocket.open(@address, @port) }
    @socket = Net::InternetMessageIO.new(sock)
    @socket.read_timeout = 60 #@read_timeout

    check_response(critical { recv_response() })
    do_helo(helodomain)

    if starttls
      raise 'openssl library not installed' unless defined?(OpenSSL)
      ssl = OpenSSL::SSL::SSLSocket.new(sock)
      ssl.sync_close = true
      ssl.connect
      @socket = Net::InternetMessageIO.new(ssl)
      @socket.read_timeout = 60 #@read_timeout
      do_helo(helodomain)
    end

    authenticate user, secret, authtype
    @started = true
  ensure
    unless @started
      # authentication failed, cancel connection.
      @socket.close if not @started and @socket and not @socket.closed?
      @socket = nil
    end
  end

  def authenticate(user, secret, authtype = DEFAULT_AUTH_TYPE)
    check_auth_method authtype
    check_auth_args user, secret
    send auth_method(authtype), user, secret
  end

  def do_helo(helodomain)
    begin
      if @esmtp
        ehlo helodomain
      else
        helo helodomain
      end
    rescue Net::ProtocolError
      if @esmtp
        @esmtp = false
        @error_occured = false
        retry
      end
      raise
    end
  end

  def check_auth_args( user, secret)
    unless user
      raise ArgumentError, 'SMTP-AUTH requested but missing user name'
    end
    unless secret
      raise ArgumentError, 'SMTP-AUTH requested buy missing secrete phrase'
    end
  end
   
  def check_auth_method(type)
      unless respond_to?(auth_method(type), true)
      raise ArgumentError, "wrong authentication type #{type}"
    end
  end

  def auth_method(type)
    "auth_#{type.to_s.downcase}".intern
  end

  def starttls
    getok('STARTTLS') rescue return false
    return true
  end

  def quit
    begin
      getok('QUIT')
    rescue EOFError
    end
  end
end

