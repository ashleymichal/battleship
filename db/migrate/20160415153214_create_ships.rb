class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :ship_type
      t.integer :hits

      t.timestamps null: false
    end
  end
end
