class Support::UserForm
  def genders
    User.genders.keys.map {|g| [I18n.t("users.genders.#{g}"), g]}
  end

  def blood_types
    User.blood_types.keys.map {|g| [I18n.t("users.blood_types.#{g}"), g]}
  end
end
