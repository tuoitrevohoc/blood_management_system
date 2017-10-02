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
end
