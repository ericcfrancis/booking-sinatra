class Rooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :rate
      t.string :capacity
      t.timestamps null: false
    end
  end
end
