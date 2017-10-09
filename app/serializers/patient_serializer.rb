class PatientSerializer < ActiveModel::Serializer
  attributes :id
  attribute :text, if: :ajax_request?

  def text
    blood_type = I18n.t "users.blood_types.#{object.blood_type}"
    "#{object.name} (#{blood_type}) - #{object.address}"
  end

  def ajax_request?
    @instance_options[:ajax_request]
  end
end
