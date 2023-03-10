class ProjectActivity < ApplicationRecord
  belongs_to :comment, optional: true
  belongs_to :admin_user
  belongs_to :project

  enum change_type: {
    comment: 'comment',
    status: 'status',
    comment_and_status: 'comment_and_status'
  }, _suffix: true
end
