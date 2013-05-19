class AddNoteToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :note, :string
  end
end
