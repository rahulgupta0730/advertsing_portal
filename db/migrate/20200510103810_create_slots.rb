class CreateSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :base_price
      t.string :status
      t.integer :agent_id
      t.integer :organization_id
      t.integer :provider_id
      t.decimal :final_price
      t.timestamps
    end
  end
end
