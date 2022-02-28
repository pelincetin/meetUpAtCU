Given /the following users exist/ do |profiles_table|
  profiles_table.hashes.each do |profile|
      prof = Profile.new(uni: profile[:uni], name: profile[:name], bio: profile[:bio], major: profile[:major], degree: profile[:degree], college: profile[:college], email: profile[:email], classes: profile[:classes],hobbies: profile[:hobbies],random_match: profile[:random_match])
      prof.image.attach(io: URI.open(profile[:image]), filename: '#{profile[:name]}.jpg')
      prof.save!
    end
  end

  Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    regexp = /#{e1}.*{e2}/m
    regexp.match(page.body)
  end

  When /I check the following colleges: (.*)/ do |college_list|
    college_list.split(', ').each do |college|
        
        check("colleges_#{college}")
       
    end
  end

  When /I uncheck the following colleges: (.*)/ do |college_list|
    
    college_list.split(', ').each do |college|
        #puts "colleges_#{college}"

        uncheck("colleges_#{college}")
    end
    #puts page.body
  end

  When /I check the following degrees: (.*)/ do |degree_list|
    degree_list.split(', ').each do |degree|
      check("degrees_#{degree}")
    end
  end  

  When /I uncheck the following degrees: (.*)/ do |degree_list|
    degree_list.split(', ').each do |degree|
      uncheck("degrees_#{degree}")
    end
  end  
  

  Then /I should see all the users/ do
    # Make sure that all the profiles in the app are visible in the table
    
    Profile.all.each do |profile|
      step %{I should see "#{profile.name}"}
    end
  end

  Then /(.*) users should exist/ do | n_seeds |
    Profile.count.should be n_seeds.to_i
  end

  When /^I follow image link "([^"]*)"$/ do |img_alt|
    find(:xpath, "//img[@alt = '#{img_alt}']/parent::a").click()
  end

  Then /^I should see image "([^"]*)"$/ do |image|
    page.should have_xpath("//img[contains(@src, ""#{image}"")]")
  end


  When ('I am login as {string}') do |string|
    visit ("/auth/test")
    #visit path_to("the new profile page")
    #fill_in("Name", :with => "JD")
    #fill_in("UNI", :with => string)
    #click_button("Save Changes")
  end
  When ('I upload a picture')do 
    attach_file("app/assets/images/bunny.jpeg")
  end

  # I select option "BC" from "college"    
  When /^I select option "(.*)" from element "(.*)"/ do |option, selector|
    all(selector).last.find(:option, option).select_option
  end

#Then(/^I select "([^"]*)" from "([^"]*)" dropdown list$/) do |param1, city|
  Then(/^I select option "([^"]*)" from "([^"]*)"$/) do |option, selector|
    select(option, :from =>selector)
  end

  When('I present page body') do
   puts page.body
  end
  
Given('I check {string}') do |string|
  check(string)
end