class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |g|
      g.references :creator
      g.references :joiner
      g.string :board

      g.timestamps
    end
  end
end
