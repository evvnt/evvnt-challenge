class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :summary
      t.datetime :start_time
      t.datetime :end_time
      t.text :keywords
      t.integer :remote_id
      t.datetime :last_updated

      t.timestamps
    end
  end
end
