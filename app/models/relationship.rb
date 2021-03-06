class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user, presence: true
  validates :follow_id, presence: true

end
