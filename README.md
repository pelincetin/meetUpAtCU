# Meet Up At CU ☕

Meet Up At CU is a web app for connecting students who go to Columbia University.

Pelin Cetin - pc2807

Angela Peng - ap4042

Alvin Wu - aw3254

Zixuan Zhou - zz2889

## Features

Our current iteration of the app illustrates how a user can navigate the site to find someone they could meet up with on campus. On the homepage, you can view all the profiles added to the site and you can filter by colleges. You can also click on a profile's image to view more info about the profile such as their classes, hobbies, degree, and bio.

We've added a login system using Google OAuth. The sign up function will automatically create a default profile for the new user. We've also tweaked the login tests such that they can create a fake login for a user without dealing with 3rd-party authorization. 

After you sign up and then log in, you can also send a message to the other user. True email sending has been implemented. We've set up a Gmail account and the emails are sent from there. It currently works on both localhost and Heroku. In order to make this repo public, we have deleted all references to the set up email account, its key and S3 keys, where we were hosting the pictures. If anyone is interested in forking our project, please look at the config/env folder to set it up accordingly. 

After logging in, the user can view their own profile or they can logout. The 'View Profile' selection will direct the user to the logged in user's profile and the user can find their profile there. This page includes two buttons: 'Edit Profile' and 'Delete Profile'. If the user clicks on 'Edit Profile', we've designed the system such that you can change your major, college, classes, hobbies, degree, bio, random match, and picture. If the user clicks on 'Delete Profile', their profile will disappear from the dashboard.

We have also implemented a "randomly match me" option. This function searches through the database to find another user who is okay with being matched randomly and then sends both of them an email.

## Installation and Setup

### App Dependencies

Ruby v2.6.8

Rails v5.2.6

PostgreSQL v12.8.0

SQLite3 v3.31.1

Yarn v1.22.15

Node v12.22.7

### Installation

Git clone our repository

Follow https://stackoverflow.com/questions/37720892/you-dont-have-write-permissions-for-the-var-lib-gems-2-3-0-directory to install ruby 2.6.8 (rbenv install 2.6.8)

gem install rails

gem install bundler

cd meetUpAtCU

gem install rails

bundle install

Change the following located in the config/enviroments/development.rb and config/enviroments/test.rb to the URL and port that you’re running this on: 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.action_mailer.default_url_options = { host:'127.0.0.1', port: '9292'}

Run the following command in the terminal to set the env variable:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;export GOOGLE_USERNAME=""

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;export GOOGLE_PASSWORD=""


Check that it has been set properly by running these:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo $GOOGLE_USERNAME

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo $GOOGLE_PASSWORD

### For local development:

bundle exec rackup

### For Codio:

rails server -b 0.0.0.0

## Databases

if seed changed => rake db:reset db:seed

Database for Test: SQLite3.

Database for Production: PostgreSQL.

### For Codio:

sudo su

sudo -u postgres psql

create database my_database_development;

create user codio;

grant all privileges on database my_database_development to codio;

\q

### For Local:

psql

create database my_database_development;

create user <replace_with_name>;

grant all privileges on database my_database_development to <replace_with_name>;

\q

## Test

Clarification: the coverage is due to the google auth, which leads to 0% coverage on sessions_controller.rb and 50% coverage on profile.rb. Failure may occur due to hidden environment variables.

It’s difficult to test the log in functionality because of Google OAuth. Therefore, we have tweaked the login workflow such that if the user inputs a UNI that already exists in our database, they will be logged in.(this is only exist for testing purposese for iteration 2)

For running one cucumber feature file:

bundle exec cucumber features/[file name] 

For running all cucumber feature file:

bundle exec cucumber features/*

bundle exec rspec

## Heroku Tips

Remember to run: heroku run rake db:create db:migrate db:seed for the first time

If seed changed:

heroku restart

heroku pg:reset DATABASE

heroku run rake db:migrate

heroku run rake db:seed

## GitHub URL

https://github.com/pelincetin/meetUpAtCU

## Heroku Deploy URL

https://fast-tundra-18884.herokuapp.com/
