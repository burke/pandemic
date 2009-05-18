namespace :cache do
  desc 'Sweep Static Page Cache'
  task :sweep => :environment do
    puts "Sweeping Cache..."
    StaticSweeper.sweep
  end
end
