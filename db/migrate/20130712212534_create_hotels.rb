class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.references :trip
      t.string :name
      t.text :description
      t.float :price
      t.string :remote_api_id
      t.timestamps
    end
    add_index :hotels, :trip_id
  end
end
