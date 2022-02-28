require 'open-uri'
class  ProfilesController < ApplicationController

  # show profile of arbitrary user
  def show
    @profile = Profile.find_by(uni: params[:id]) || Profile.find_by(uni: session[:user_id])
  end

  def show_my_profile
    if !session[:user_id]
			# if someone is not logged in and somehow
			# managed to get to personal profile page, redirect them to the log in page
      flash[:notice] = "You need to login"
			redirect_to profiles_path
		end
		@profile = Profile.find_by(uni: session[:user_id])
  end

  # call this to create a profile
  def create
    profile = profile_params
    #@profile = Profile.create!(profile_params)
    if profile[:uni].blank? || profile[:name].blank?
      flash[:notice] = "Missing UNI or Name"
      redirect_to profiles_path
      return
    end
    if Profile.find_by(uni:profile[:uni])
      flash[:notice] = "User exists. Please login instead"
      redirect_to profiles_path
      return
    end
    @profile = Profile.new(uni: profile[:uni], name: profile[:name], bio: profile[:bio], major: profile[:major], college: profile[:college], email: profile[:email], hobbies: profile[:hobbies], degree: profile[:degree], classes: profile[:classes])
    if profile[:image].blank?
      @profile.image.attach(io: URI.open(""), filename: '#{profile[:name]}.jpg')
    else
      @profile.image.attach(profile[:image])
    end
    @profile.save!
    session[:user_id] = @profile[:uni]
    flash[:notice] = "#{@profile.name} was successfully created."
    redirect_to profiles_path
  end

  def edit

  end

  # get the form to edit a user's profile
  def edit_me
    @profile = Profile.find_by(uni: session[:user_id])
  end

  def update_me
    @profile = Profile.find_by(uni: session[:user_id])
    @profile.bio = profile_params[:bio]
    @profile.major = profile_params[:major]
    @profile.college = profile_params[:college]
    @profile.degree = profile_params[:degree]
    @profile.hobbies = profile_params[:hobbies]
    @profile.classes = profile_params[:classes]
    if params[:random_match] == "1"
      @profile.random_match = true
    else
      @profile.random_match = false
    end
    if profile_params[:image].blank?
      if !@profile.image.attached?
        @profile.image.attach(io: URI.open(""), filename: '#{profile[:name]}.jpg')
      end
    else
      @profile.image.attach(profile_params[:image])
    end
    @profile.save
    flash[:notice] = "#{@profile.name} was successfully updated."
    redirect_to show_my_profile_path
  end

  def new
  #default rendering
  end

  def index
    @all_colleges = Profile.all_colleges
    @all_degrees = Profile.all_degrees
    
    if params[:colleges].nil?
      @colleges_to_show = @all_colleges
    else
      @colleges_to_show = params[:colleges].keys
    end
    
    if params[:degrees].nil?
      @degrees_to_show = @all_degrees
    else
      @degrees_to_show = params[:degrees].keys
    end
    
    sort = 'name'
    @profiles = Profile.order("#{sort} ASC").with_college(@colleges_to_show).with_degree(@degrees_to_show)
  end

  # call this to update the bio
  def update

  end

  def destroy
    @profile = Profile.find_by(uni: params[:id])
    @profile.destroy
    session[:user_id] = nil
    flash[:notice] = "Profile '#{@profile.name}' deleted."
    redirect_to profiles_path
  end

  private
# Making "internal" methods private is not required, but is a common practice.
# This helps make clear which methods respond to requests, and which ones do not.
  def profile_params
    params.require(:profile).permit(:uni, :name, :image, :bio, :major, :college, :email, :hobbies, :degree, :classes, :random_match)
  end
end
