class RandomMatch < ActiveRecord::Migration[4.2]
  def change
    change_table :profiles do |t|
      t.boolean :random_match
    end
  end
end