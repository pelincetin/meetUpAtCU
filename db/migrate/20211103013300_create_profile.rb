class CreateProfile < ActiveRecord::Migration[4.2]
  def up
    create_table :profiles do |t|
  		t.integer  :user_id
  		t.string   :name
  		t.string   :image
  		t.string   :bio
  		t.string   :major
  		t.string   :college
  		t.string   :email
  	end
  end

  def down
    drop_table :profiles
  end
end
