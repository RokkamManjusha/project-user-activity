require 'rails_helper'
require 'spec_helper'
require 'pry'
RSpec.describe Projects::EntryPoint do
  let(:admin_user) { AdminUser.create(email: 'test@gmail.com', password: 'password') }
  let(:comment) { '' }


  describe '#Build project without comments' do
    subject(:build_project) do
      described_class.new(title: 'test project',
        description: 'description',
        reference_number: '1244DCWW',
        status: :started,
        admin_user_id: admin_user.id,
        comment_body: comment
      ).call

    end
    context 'when required params has been passed' do
      it 'should create project' do
        build_project

        expect(Project.all.count).to eq(1)
        expect(Project.first.admin_user.email).to eq(admin_user.email)
        expect(Project.first.status).to eq('started')
        expect(Project.first.project_activities.count).to eq(1)
      end
    end

    context 'when comments params has been passed' do
      let(:comment) { 'project comments' }
      it 'should create project' do
        build_project

        expect(Project.all.count).to eq(1)
        expect(Project.first.comments.count).to eq(1)
        expect(Project.first.comments.first.body).to eq(comment)
        expect(Project.first.project_activities.count).to eq(1)
      end
    end
  end
end
