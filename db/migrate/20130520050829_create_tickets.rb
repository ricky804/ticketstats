class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :customer

      t.timestamps
    end
    add_index :tickets, :customer_id
  end
end
