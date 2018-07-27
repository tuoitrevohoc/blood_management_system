class HistorySerializer < ActiveModel::Serializer
  attributes :id, :date, :donation_type, :user_id, :admin_name, :admin_id, :created_at, :updated_at, :deleted_at
  has_one :place

  def donation_type
    I18n.t "histories.donation_types.#{object.try :donation_type}"
  end

  def date
    I18n.l object.try(:date), format: :default_date
  end

  def admin_name
    object.admin_name
  end

  def admin_id
    object.admin_id
  end
end
