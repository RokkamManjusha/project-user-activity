# README

Project conversation history:

This repo contains the code for project conversation history.
* Using this app, users can create a project and can see other user/own comments on the project activity panel.
* The project activity panel will display comment and status history of the project and respective user details on the project page.


Tech Stack:
* Ruby on Rails (Ruby 2.7.7)
* Rspec
* In order to track project activity by user I've created a 'ProjectActivity' model using STI(single table inheritance). I've used change_type: attribute and enum values based on requirement to find what type of changes made on a project. At present I've defined 3 types of change type "1. status 2. comment and 3.comment_and_status". Based on these types, we can find user details to track the author of the change.
* I've decoupled modules to reduce complexity and followed SOLID principles to use this code to build API's in future.

UI:
* In order to build a project dashboard and filters for quick UI I've chosen 'active_admin' gem instead of Tailwind CSS for now.


Configuration:

Run Application:
* Please clone the 'project-user-activity' git repository into your local.
* On project path please run `bundle install`
      $: bundle install
* Run migrations and setup database `bundle exec rails db:setup`
     $: bundle exec rails db:setup
* App URL: localhost:3000/admin/login

NOTE: We no need to sign up for below user details.When we run db:setup seeds file will generate by default credentials.
  Email: 'admin@example.com'
  Password: 'password'

* How to run the test suite

  $: bundle exec rspec spec/units

Questions:
1. Can any user comment on the project?

My assumption is Yes. So I've defined the column project.admin_user_id  which will get updated while order creation and it won't get updated on edit action to make sure the author of the project doesn't change but any user can comment on the project and change status. It will log on project activity .


Thanks for taking time to review my code.
