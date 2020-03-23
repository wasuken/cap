class CreateHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :hosts do |t|
      t.string :name, null: false
      t.string :htoken, null: false

      t.timestamps
    end
    add_index :hosts, :htoken, unique: true
  end
end
