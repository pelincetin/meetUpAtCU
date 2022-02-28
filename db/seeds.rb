# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


profiles = [{:uni => 'pc2807', :name => 'Pelin Cetin', :bio=> 'code', :major => 'CS', :college => 'SEAS', :email=>'pc2807@columbia.edu', :degree=> "Masters", :classes=> "Engineering: Software as a Service", :hobbies=> "Anime, video games, photography", :image=>'', :random_match=>true},
          {:uni => 'zz2889', :name => 'Zixuan Zhou', :bio=> 'code', :major => 'CS', :college => 'SEAS', :email=>'zz2889@columbia.edu', :degree=> "Masters", :classes=> "Engineering: Software as a Service", :hobbies=> "Video games", :image=> '', :random_match=>true},
          {:uni => 'aw3254', :name => 'Alvin Wu', :bio=> 'code', :major => 'CS', :college => 'GS', :email=>'aw3254@columbia.edu', :degree=> "Undergrad", :classes=> "Engineering: Software as a Service", :hobbies=> "Finding new restaurants", :image=> '', :random_match=>true},
      	  {:uni => 'ap4042', :name => 'Angela Peng', :bio=> 'code', :major => 'CS', :college => 'BC', :email=>'ap4042@barnard.edu', :degree=> "Undergrad", :classes=> "Engineering: Software as a Service", :hobbies=> "Listening to music", :image=> '', :random_match=>true},
      	  {:uni => 'jd0000', :name => 'Jane Doe', :bio=> 'money', :major => 'Econ', :college => 'CC', :email=>'pelcetin98@gmail.com', :degree=> "PhD", :classes=> "User Interface Design", :hobbies=> "Swimming", :image=>'', :random_match=>true},
  	 ]

profiles.each do |profile|
  prof = Profile.new(uni: profile[:uni], name: profile[:name], bio: profile[:bio], major: profile[:major], college: profile[:college], email: profile[:email], degree: profile[:degree], classes: profile[:classes], hobbies: profile[:hobbies], random_match: profile[:random_match])
  prof.image.attach(io: URI.open(profile[:image]), filename: '#{profile[:name]}.jpg')
  prof.save!
end
