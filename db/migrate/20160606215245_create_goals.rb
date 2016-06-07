class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.boolean :public, null: false
      t.boolean :completed, null: false
      t.integer :user_id, null: false, index: true
      t.string :details, null: false
      t.integer :cheers

      t.timestamps null: false
    end
  end
end
