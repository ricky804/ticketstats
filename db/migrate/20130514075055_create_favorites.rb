class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user
      t.references :ticket

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :ticket_id
  end
end
