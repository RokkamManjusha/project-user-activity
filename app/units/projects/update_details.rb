module Projects
  ProjectError = Class.new(StandardError)

  class UpdateDetails
    attr_reader :project_id, :title, :reference_number, :description, :status, :admin_user_id, :comment_body, :change_type
    def initialize(project_id:, admin_user_id:, status:, reference_number:, title: , description: , comment_body: )
      @project_id = project_id
      @title = title
      @reference_number = reference_number
      @description = description
      @status = status
      @admin_user_id = admin_user_id
      @comment_body = comment_body
      @change_type = nil
    end

    def call
      rasie ActiveRecord::RecordInvalid, 'Project not found' if project.blank?
      project.update!(title: title,
                     description: description,
                     reference_number: reference_number,
                     status: status)
      @change_type = :status if project.saved_change_to_status?
      if comment_body.present?
         comment_obj = Comment.create!(body: comment_body, project: project)
         @change_type = change_type == :status ? :comment_and_status : :comment
      end
      return project unless @change_type

      BuildProjectActivity.new(project_id: project.id,
                               comment_id: comment_obj&.id,
                               admin_user_id: admin_user_id,
                               activity_type: @change_type,
                               status: status)
                          .call
      project
    rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid => e
      raise ProjectError, e.message
    end

    private

    def project
      @project ||= Project.find(project_id)
    end

    def create_project
      Project.create!(title: title,
                      description: description,
                      status: status,
                      admin_user_id: admin_user_id)
    end
  end
end
