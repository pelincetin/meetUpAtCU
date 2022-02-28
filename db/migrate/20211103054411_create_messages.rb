class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :from_uni
      t.string :to_uni
      t.datetime :created_at

      t.timestamps
    end
  end
end
