class AddInfo < ActiveRecord::Migration[5.2]
  def change
   add_column :profiles, :hobbies, :string
   add_column :profiles, :classes, :string
   add_column :profiles, :degree, :string
  end
end
