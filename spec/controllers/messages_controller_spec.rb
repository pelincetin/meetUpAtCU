require 'rails_helper'
require 'open-uri'
RSpec.describe MessagesController, type: :controller do
  
    describe "creates" do
        it "messages with valid parameters" do
          prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu')
          prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
          prof.save!
          prof1 = Profile.new(uni: 'ap4042', name: 'Angela Peng', bio: 'hello', major: 'Computer Science', college: 'BC', email: 'ap4042@barnard.edu')
          prof1.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
          prof1.save!
          params = {:message => {:text => 'hello', :from_uni => 'aw3254',:created_at => '10/10/2013', :updated_at => '10/10/2013'},:to_uni => 'ap4042', :name => 'Angela Peng', :id => 'ap4042'}
          get :create, params: params, session: {:user_id => 'aw3254'}
          expect(response).to redirect_to profiles_path
          expect(flash[:notice]).to match(/Your message to Angela Peng was successfully sent./)
          Message.destroy_all
        end
      end
    
      describe "creates" do
        it "sending messsage without being logged in" do
          params = {:message => {:text => 'hello', :from_uni => 'aw3254',:created_at => '10/10/2013', :updated_at => '10/10/2013'},:to_uni => 'ap4042', :name => 'Angela Peng', :id => 'ap4042'}
          get :create, params: params
          expect(response).to redirect_to profiles_path
          expect(flash[:notice]).to match(/Please create a profile using your uni and login/)
          Message.destroy_all
        end
      end

      describe "matches" do
        it "does not match because there are not enough users" do
          prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu')
          prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
          prof.save!
          post :random_create, session: {:user_id => 'aw3254'}
          expect(flash[:notice]).to match(/Unfortunately, we don’t have enough users with random matching opted in right now. Please check back later!/)
          expect(response).to redirect_to profiles_path
        end
      end

      describe "matches" do
        it "successfuly matches users" do
          prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu',random_match: true)
          prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
          prof.save!
          prof1 = Profile.new(uni: 'ap4042', name: 'Angela Peng', bio: 'hello', major: 'Computer Science', college: 'BC', email: 'ap4042@barnard.edu',random_match: true)
          prof1.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
          prof1.save!
          post :random_create, session: {:user_id => 'aw3254'}
          expect(flash[:notice]).to match(/You and Angela Peng were successfully matched./)
          expect(response).to redirect_to profiles_path
        end
      end

  end
  