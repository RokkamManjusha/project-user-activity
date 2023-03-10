class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :project
  has_one :project_activities
end
