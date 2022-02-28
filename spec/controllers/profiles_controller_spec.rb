require 'rails_helper'
require 'open-uri'

RSpec.describe ProfilesController, type: :controller do
  
  describe "show" do
    it "show a specific profile" do
      prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu')
      prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof.save!
      get :show, params: {id: prof.uni}
      expect(assigns(:profile)).to eq(prof)
      expect(response).to render_template "show"
      Profile.delete_all
    end
  end

  describe "create" do
    it "create a specific profile with valid parameters" do
      params = {:profile => {uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu'}}
      get :create, params: params
      expect(flash[:notice]).to match(/Alvin Wu was successfully created./)
      Profile.delete_all
    end
  end

  describe "create" do
    it "create a profile with invalid parameters" do
      params = {:profile => {uni: '', name: '', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu'}}
      get :create, params: params
      expect(flash[:notice]).to match(/Missing UNI or Name/)
      Profile.delete_all
    end
  end

  describe "create" do
    it "logs in with already created pofile " do
      params = {:profile => {uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu'}}
      prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu')
      prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof.save!
      get :create, params: params
      expect(response).to redirect_to profiles_path
    end
  end

  describe "destroy" do
    it "removes a profile from the given list" do
      prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu')
      prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof.save!
      delete :destroy, :params => {:id => prof.uni}
      expect(response).to redirect_to profiles_path
      expect(flash[:notice]).to match (/Profile 'Alvin Wu' deleted./)
    end
  end

  describe "index" do
    it "displays all profiles" do
      prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'code', major: 'CS', college: 'GS', email: 'aw3254@columbia.edu', degree: 'Undergrad', classes: 'Engineering: Software as a Service', hobbies: 'Finding new restaurants',random_match: true)
      prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof.save!
      get :index
      expect(assigns(:profiles)).to eq([prof])
      expect(response).to render_template "index"
      Profile.delete_all
    end
  end

  describe "index" do
    it "displays profiles with correspondinbg college" do
      prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'code', major: 'CS', college: 'GS', email: 'aw3254@columbia.edu', degree: 'Undergrad', classes: 'Engineering: Software as a Service', hobbies: 'Finding new restaurants',random_match: true)
      prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof.save!
      get :index,:params => {:colleges => {'GS' => "1"}}
      expect(assigns(:profiles)).to eq([prof])
      expect(response).to render_template "index"
      Profile.delete_all
    end
  end

  describe "show_my_profile without login" do
    it "redirects to homepage" do
      get :show_my_profile, session: {}
      expect(response).to redirect_to profiles_path
    end
  end

  describe "show_my_profile with login" do
    it "shows profile of login user" do
      prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu')
      prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof.save!
      get :show_my_profile, session: {:user_id => 'aw3254'}
      expect(assigns(:profile)).to eq(prof)
    end
  end

  describe "edit profile page" do
    it "shows edit page" do 
      prof = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'hello', major: 'Computer Science', college: 'GS', email: 'aw3254@columbia.edu')
      prof.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof.save!
      get :edit_me, session: {:user_id => 'aw3254'}
      expect(assigns(:profile)).to eq(prof)
    end
  end

  describe "update profile " do
    it "update the profile with new information" do 
      prof1 = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'none', major: 'none', college: 'none', email: 'aw3254@columbia.edu')
      prof1.image.attach(io: URI.open(''), filename: 'Alvin_Wu.jpg')
      prof1.save!
      post :update_me, params: {:profile => {bio: 'hello',major: 'Computer Science',college: 'GS' }, random_match: "1"}, session: {:user_id => 'aw3254'}
      prof = Profile.where(uni: 'aw3254').first
      expect(prof.bio).to eq("hello")
      expect(flash[:notice]).to match (/Alvin Wu was successfully updated./)
    end
  end

  describe "update profile " do
    it "update the profile without image" do 
      prof1 = Profile.new(uni: 'aw3254', name: 'Alvin Wu', bio: 'none', major: 'none', college: 'none', email: 'aw3254@columbia.edu')
      prof1.save!
      get :update_me, params: {:profile => {bio: 'hello',major: 'Computer Science',college: 'GS' }}, session: {:user_id => 'aw3254'}
      prof = Profile.where(uni: 'aw3254').first
      expect(prof.bio).to eq("hello")
      expect(flash[:notice]).to match (/Alvin Wu was successfully updated./)
    end
  end
  
end