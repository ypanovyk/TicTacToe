class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :creator
      t.integer :participant
      t.string :status
      t.integer :winner
      t.integer :whose_turn

      t.timestamps
    end
  end
end
