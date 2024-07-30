# README

<b>Project conversation history:</b>

This repo contains the code for project conversation history.
* Using this app, users can create a project and can see other user/own comments on the project activity panel.
* The project activity panel will display comment and status history of the project and respective user details on the project page.


<b>Tech Stack:</b>
* Ruby on Rails (Ruby 2.7.7)
* Rspec
* In order to track project activity by user I've created a 'ProjectActivity' model using STI(single table inheritance). I've used change_type: attribute and enum values based on requirement to find what type of changes made on a project. At present I've defined 3 types of change type "1. status 2. comment and 3.comment_and_status". Based on these types, we can find user details to track the author of the change.
* I've decoupled modules to reduce complexity and followed SOLID principles to use this code to build API's in future.
* Added model validations and database indexes in order to make sure there will be no duplicate project records.


<b>Configuration:</b>

<b>Run Application:</b>
* Please clone the 'project-user-activity' git repository into your local.
* On project path please run `bundle install`

* Run migrations and setup database `bundle exec rails db:setup`

* Start rails server

* <b>App URL: localhost:3000/admin/login </b>

<b>NOTE:</b> We no need to sign up for below user details.When we run db:setup seeds file will generate by default credentials.

  <b>Email:</b> 'admin@example.com'

  <b>Password:</b> 'password'

* How to run the test suite

  $: bundle exec rspec spec/units

<b>Questions:</b>
1. Can any user comment on the project?

My assumption is Yes. So I've defined the column project.admin_user_id  which will get updated while order creation and it won't get updated on edit action to make sure the author of the project doesn't change but any user can comment on the project and change status. It will log on project activity .


Thanks for taking time to review my code.
I've attached screenshots for reference. Please find the below

<img width="1433" alt="Screenshot 2023-03-10 at 09 43 59" src="https://user-images.githubusercontent.com/20990144/224282696-da949d2e-5e3e-48cb-8718-de8f53f4dad3.png">

<img width="1409" alt="Screenshot 2023-03-10 at 09 43 29" src="https://user-images.githubusercontent.com/20990144/224282673-6cbf4bd3-d4eb-4e2d-8243-f4a681dede36.png">
