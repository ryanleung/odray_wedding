class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :plusOneAmount
      t.string :rsvpCode
      t.boolean :responded

      t.timestamps
    end
  end
end
