class DeleteImage < ActiveRecord::Migration[4.2]
  def change
    change_table :profiles do |t|
      t.remove :image
    end
  end
end
