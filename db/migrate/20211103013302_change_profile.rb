class ChangeProfile < ActiveRecord::Migration[4.2]
  def change
    change_table :profiles do |t|
      t.remove :user_id
      t.string :uni
    end
  end
end
