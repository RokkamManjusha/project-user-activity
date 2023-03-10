require 'rails_helper'
require 'spec_helper'
require 'pry'
RSpec.describe Projects::UpdateDetails do
  let(:admin_user) { AdminUser.create(email: 'test@gmail.com', password: 'password') }
  let(:project) { Project.create(admin_user: admin_user, title: 'test project', description: 'text', reference_number: '123', status: :started) }
  let(:status) { :unassigned }

  describe '#Update project details' do
    subject(:udpate_project) do
      described_class.new(project_id: project.id,
        title: 'test project',
        description: 'description',
        reference_number: '1244DCWW',
        status: status,
        admin_user_id: admin_user.id,
        comment_body: comment
      ).call

    end
    before do
      project
    end
    context 'when project sttaus has been changed' do
      let(:status) { :completed }
      let(:comment) { '' }
      it 'should update project and create project activity' do
         expect(Project.first.status).to eq('started')

          udpate_project
          expect(Project.first.status).to eq('completed')
          expect(Project.first.project_activities.last.change_type).to eq('status')
          expect(Project.first.project_activities.count).to eq(1)
      end
    end

    context 'when new comments added to project but status unchanged' do
      let(:comment) { 'project comments' }
      let(:status) { :started }
      it 'should update project and create project activity' do
        expect(Project.first.comments).to eq([])

         udpate_project
         expect(Project.first.comments.count).to eq(1)
         expect(Project.first.comments.first.body).to eq(comment)
         expect(Project.first.project_activities.last.change_type).to eq('comment')
         expect(Project.first.project_activities.count).to eq(1)
      end
    end

    context 'when new comments and status has changes' do
      let(:comment) { 'project comments' }
      it 'should update project and create project activity' do
        expect(Project.first.comments).to eq([])

         udpate_project
         expect(Project.first.comments.count).to eq(1)
         expect(Project.first.comments.first.body).to eq(comment)
         expect(Project.first.project_activities.last.change_type).to eq('comment_and_status')
         expect(Project.first.project_activities.count).to eq(1)
      end
    end
  end
end
