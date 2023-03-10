ActiveAdmin.register ProjectActivity, as: 'Project conversation history' do

  belongs_to :project
  actions :all, except: %i[new edit create destroy]

  index do
      column 'project' do |activity|
        activity.project.name
      end
  end
end
