class AddEmailAndWishes < ActiveRecord::Migration
  def change
    add_column :guests, :email, :string
    add_column :guests, :comments, :text
  end
end
