class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :trip
      t.string :name
      t.text :description
      t.float :price

      t.timestamps
    end
    add_index :activities, :trip_id
  end
end
