class AddTagToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :tag, :string
  end
end
