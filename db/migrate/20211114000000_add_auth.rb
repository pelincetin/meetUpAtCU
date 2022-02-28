class AddAuth < ActiveRecord::Migration[5.2]
  def change
   add_column :profiles, :google_token, :string
   add_column :profiles, :google_refresh_token, :string
  end
end
