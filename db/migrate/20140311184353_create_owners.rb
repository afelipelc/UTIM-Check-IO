class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :nombre
      t.string :tipo
      t.string :clave
      t.string :pe

      t.timestamps
    end
  end
end
