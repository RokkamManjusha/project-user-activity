module Projects
  ProjectActivityError = Class.new(StandardError)

  class BuildProjectActivity
    attr_reader :project_id, :comment_id, :admin_user_id, :activity_type, :status
    def initialize(project_id:, comment_id:, admin_user_id:, activity_type:, status: nil)
      @project_id = project_id
      @comment_id = comment_id
      @admin_user_id = admin_user_id
      @activity_type = activity_type
      @status = status
    end

    def call
      activity_record = ProjectActivity.new(project_id: project_id,
        admin_user_id: admin_user_id,
        change_type: activity_type
      )
      activity_record.comment_id = comment_id unless activity_type == :status
      activity_record.status = status unless activity_type == :comment
      activity_record.save!
    rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid => e
      raise ProjectActivityError, e.message
    end
  end
end
