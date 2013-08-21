class RenameEmailsToRequestors < ActiveRecord::Migration
  def up
    rename_table :emails, :requestors
  end

  def down
    rename_table :requestors, :emails
  end
end
