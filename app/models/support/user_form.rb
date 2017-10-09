class Support::UserForm
  def genders
    User.genders.keys.map {|g| [I18n.t("users.genders.#{g}"), g]}
  end

  def blood_types
    User.blood_types.keys.map {|g| [I18n.t("users.blood_types.#{g}"), g]}
  end

  def donateable
    Settings.statuses.map {|k, v| [I18n.t("users.statuses.#{k}"), v]}
  end

  def roles
    User.roles.keys.map {|role| [I18n.t("users.roles.#{role}"), role]}
  end

  def departments
    Department.joins(:place).select("departments.*, places.name as place_name").map {|d| ["#{d.name} - #{d.place_name}", d.id, {data: {doctor: d.head_doctor}}]}
  end
end
