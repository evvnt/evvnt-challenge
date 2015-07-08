class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :keywords
      t.integer :remote_id

      t.timestamps
    end
  end
end
