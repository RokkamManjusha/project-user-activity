require 'rails_helper'
require 'spec_helper'
require 'pry'
RSpec.describe Projects::BuildProjectActivity do
  let(:admin_user) { AdminUser.create(email: 'test@gmail.com', password: 'password') }
  let(:project) { Project.create(admin_user: admin_user, title: 'test project', description: 'text', reference_number: '123', status: :unassigned) }
  let(:comment) { Comment.create(project: project, body: 'project comment 1')}
  let(:status) { :unassigned }
  describe '#Build project activity' do
    subject(:create_project_activity) do
      described_class.new(project_id: project.id,
        admin_user_id: admin_user.id,
        status: status,
        comment_id: comment.id,
        activity_type: activity_type
      ).call

    end
    before do
      project
    end
    context 'when project status has been changed' do
      let(:activity_type) { :status }
      it 'should update project and create project activity' do
        expect(Project.first.project_activities.count).to eq(0)
        create_project_activity
        expect(Project.first.project_activities.first.change_type).to eq('status')
        expect(Project.first.project_activities.first.status).not_to be_empty
        expect(Project.first.project_activities.first.comment_id).to be_nil
        expect(Project.first.project_activities.count).to eq(1)
      end
    end

    context 'when new comments added to project' do
      let(:activity_type) { :comment }
      it 'should create project' do
        expect(Project.first.project_activities.count).to eq(0)
        create_project_activity
        expect(Project.first.project_activities.first.change_type).to eq('comment')
        expect(Project.first.project_activities.first.status).to be_nil
        expect(Project.first.project_activities.first.comment_id).to eq(comment.id)
        expect(Project.first.project_activities.count).to eq(1)
      end
    end

    context 'when status and new comments added to project' do
      let(:activity_type) { :comment_and_status }
      it 'should create project' do
        expect(Project.first.project_activities.count).to eq(0)
        create_project_activity
        expect(Project.first.project_activities.first.change_type).to eq('comment_and_status')
        expect(Project.first.project_activities.first.status).not_to be_empty
        expect(Project.first.project_activities.first.comment_id).to eq(comment.id)
        expect(Project.first.project_activities.count).to eq(1)
      end
    end
  end
end
