class CreateRtqueues < ActiveRecord::Migration
  def change
    create_table :rtqueues do |t|

      t.timestamps
    end
  end
end
