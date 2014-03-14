class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :owner_id
      t.string :tipo
      t.string :noserie
      t.string :marca
      t.string :color
      t.text :nota, null: true
      t.datetime :registro
      t.datetime :ultimavez

      t.index :owner_id, unique: false
      t.timestamps
    end
  end
end
