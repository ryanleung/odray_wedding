class CreatePlusOnes < ActiveRecord::Migration
  def change
    create_table :plus_ones do |t|
      t.string :name
      t.boolean :rsvped, default: false
      t.integer :guest_id

      t.timestamps
    end
  end
end
