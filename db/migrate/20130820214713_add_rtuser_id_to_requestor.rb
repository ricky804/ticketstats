class AddRtuserIdToRequestor < ActiveRecord::Migration
  def change
    add_column :requestors, :rtuser_id, :integer
  end
end
