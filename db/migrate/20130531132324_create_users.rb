class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |g|
      g.string :username
      g.string :password_hash
      g.boolean :logged_in, :default => true

      g.timestamps
    end
  end
end
