class FixStatusColumnInGames < ActiveRecord::Migration
  def change
    change_column :games, :status ,:string, {:default => "new"}
  end
end
