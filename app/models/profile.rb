class Profile < ActiveRecord::Base
    has_one_attached :image
  
    def self.all_colleges
      return ['BC', 'GS', 'CC', 'SEAS']
    end
  
    def self.all_degrees
      return ['Undergrad', 'Masters', 'PhD']
    end

    def self.with_college(college_list)
      if college_list.empty?
        return self.all
      else
        return self.where(college: college_list)
      end
    end
  
    def self.with_degree(degree_list)
      if degree_list.empty?
        return self.all
      else
        return self.where(degree: degree_list)
      end
    end
  
    def self.random_select(sender)
      all_matched = self.where.not(uni: sender).where(random_match: true)
      if all_matched.empty?
        return nil
      end
      return all_matched.sample
    end

    def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
      where(email: auth.info.email).first_or_initialize do |user|
        name = auth.info.name
        email = auth.info.email
        uni = email.gsub(/([^.]+)@.+/, '\1')
        user = Profile.new(uni: uni, name: name, email: email)
        user.image.attach(io: URI.open(""), filename: '#{profile[:name]}.jpg')
        user.save!
      end
    end
end
