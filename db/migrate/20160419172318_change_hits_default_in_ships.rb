class ChangeHitsDefaultInShips < ActiveRecord::Migration
  def change
    change_column_default :ships, :hits, 0
  end
end
