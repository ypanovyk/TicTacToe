class AddDefaultsToGames < ActiveRecord::Migration
  def change
    change_column :games, :participant ,:integer, {:default => nil}
    change_column :games, :status ,:string, {:default => "new"}
    change_column :games, :winner ,:integer, {:default => nil}
    change_column :games, :whose_turn ,:integer, {:default => nil}
  end
end
