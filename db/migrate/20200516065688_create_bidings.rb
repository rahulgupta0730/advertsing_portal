class CreateBidings < ActiveRecord::Migration[6.0]
  def change
    create_table :bidings do |t|
      t.integer :bid_by
      t.decimal :bid_amounts , array: true , default:[]
      t.decimal :latest_bid
      t.references :slot, foreign_key: true
      t.timestamps
    end
  end
end
