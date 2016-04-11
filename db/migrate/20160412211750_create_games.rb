class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :board
      t.text :ships
      t.integer :score

      t.timestamps null: false
    end
  end
end
