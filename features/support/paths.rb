# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the homepage$/ then '/profiles'
    when /^google auth$/ then '/auth/google_oauth2'
    when /^the profile page$/ then '/profiles'
    when /^the profile page for "(.*)"$/
      uni = Profile.find_by(name: $1)[:uni]
      profile_path(uni)
    when /^the new profile page$/ then new_profile_path
    when /^the show my profile page$/ then show_my_profile_path
    when /^the edit page$/ then 

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
