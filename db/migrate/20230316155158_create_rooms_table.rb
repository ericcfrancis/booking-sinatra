class CreateRoomsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.decimal :rate, precision: 8, scale: 2
      t.string :capacity
      t.timestamps null: false
    end
  end
end
