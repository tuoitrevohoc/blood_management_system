class HistorySerializer < ActiveModel::Serializer
  attributes :id, :date, :donation_type, :user_id
  has_one :place

  def donation_type
    I18n.t "histories.donation_types.#{object.try :donation_type}"
  end

  def date
    I18n.l object.try(:date), format: :default_date
  end
end
