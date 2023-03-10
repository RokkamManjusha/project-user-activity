ActiveAdmin.register Project do
  permit_params :title, :status, :description, comments: %i[body]
  index do
    selectable_column
    id_column
    column :title
    column :reference_number
    column :status
    column :description
    column 'created by' do |project|
      link_to project.admin_user.email,
              admin_admin_user_path(
                id: project.admin_user.id
              )
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :reference_number
      row 'status' do |project|
         project.status.humanize
      end
      row :description
      row 'created by' do |project|
        link_to project.admin_user.email,
                admin_admin_user_path(
                  id: project.admin_user.id
                )
      end
      row :created_at
      row :updated_at
      table_for resource.comments.order('id ASC') do
        column 'Comments' do |comment|
          comment.body
        end
      end
      panel 'Project activities' do
        render 'project_activities'
      end
      # table_for resource.project_activities.order('id ASC') do
      #   column 'Project activities' do |project_activity|
      #     column project_activity.id
      #   end
      # end
    end
  end

  filter :title
  filter :status
  filter :admin_user
  filter :created_at

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)

    f.inputs do
      f.input :title
      f.input :reference_number
      f.input :status, as: :select, collection: Project.statuses, include_blank: false
      f.input :description, include_blank: false
    end
    columns do
      column do
        f.inputs 'Comments' do
          f.has_many :comments, allow_destroy: false do |comment|
            comment.input :body
          end
        end
      end
    end
    f.actions
  end

  controller do
    def create
      project = Projects::EntryPoint.new(title: params[:project][:title],
                                   description: params[:project][:description],
                                   reference_number: params[:project][:reference_number],
                                   status: params[:project][:status],
                                   admin_user_id: current_admin_user.id,
                                   comment_body: params[:comments]&&params[:comments][:body]).call
      redirect_to admin_project_path(project.id), flash: { notice: 'Created sucessfully' }
    rescue StandardError => e
      flash[:error] = "Error: #{e.message}"
    end

    def update
      new_comment_body = params[:project]['comments_attributes'].reject{ |comment_index, comment| comment.include?("id")}
      project = Projects::UpdateDetails.new(project_id: resource.id,
                                            admin_user_id: current_admin_user.id,
                                            status: params[:project][:status],
                                            reference_number: params[:project][:reference_number],
                                            title: params[:project][:title],
                                            description: params[:project][:description],
                                            comment_body: new_comment_body.values.first && new_comment_body.values.first["body"])
                                 .call

      redirect_to admin_project_path(project.id), flash: { notice: 'Updated sucessfully' }

     rescue StandardError => e
       flash[:error] = "Error: #{e.message}"
    end
  end
end
