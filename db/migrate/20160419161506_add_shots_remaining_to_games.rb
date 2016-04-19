class AddShotsRemainingToGames < ActiveRecord::Migration
  def change
    add_column :games, :shots_remaining, :integer, default: 50
  end
end
