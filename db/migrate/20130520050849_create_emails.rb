class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :customer
      t.string :email

      t.timestamps
    end
    add_index :emails, :customer_id
  end
end
