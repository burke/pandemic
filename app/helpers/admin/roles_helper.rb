module Admin::RolesHelper

  def users_count_column(record)
    record.users.size
  end

end
