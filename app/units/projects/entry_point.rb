module Projects
  ProjectError = Class.new(StandardError)

  class EntryPoint
    attr_reader :title, :description, :status, :reference_number,:admin_user_id, :comment_body
    def initialize(title:, description:, reference_number:, status:, admin_user_id:, comment_body:)
      @title = title
      @description = description
      @reference_number = reference_number
      @status = status
      @admin_user_id = admin_user_id
      @comment_body = comment_body
    end

    def call
      project = Project.new(title: title,
                            reference_number: reference_number,
                            description: description,
                            status: status,
                            admin_user_id: admin_user_id)
      project.save!
      comment = Comment.create!(body: comment_body, project: project) if comment_body.present?
      activity_type = project.comments.empty? ? 'status' : 'comment_and_status'
      BuildProjectActivity.new(project_id: project.id,
                               comment_id: comment&.id,
                               admin_user_id: admin_user_id,
                               activity_type: activity_type,
                               status: status)
                          .call
      project
      rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid => e
        raise ProjectError, e.message
      end
    end
  end
