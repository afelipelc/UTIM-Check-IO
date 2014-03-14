class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :device_id
      t.datetime :ingreso
      t.datetime :egreso

      t.index :device_id, unique: false
      t.timestamps
    end

  end
end
