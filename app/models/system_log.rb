class SystemLog < ApplicationRecord
  enum action_type: [:remove]

  belongs_to :actor, class_name: User.name, foreign_key: :actor_id, optional: true

  def target
    return nil unless self.target_id?
    klass = self.target_type.classify.constantize
    klass.find_by id: self.target_id
  end
end
