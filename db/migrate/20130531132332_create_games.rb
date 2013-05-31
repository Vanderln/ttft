class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |g|
      g.references :creator
      g.references :joiner
      g.integer :winner_id
      g.integer :turn_id
      g.string :board

      g.timestamps
    end
  end
end
