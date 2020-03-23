class CreateDsts < ActiveRecord::Migration[6.0]
  def change
    create_table :dsts do |t|
      t.integer :dport, null: false
      t.string :dip, null: false
      t.string :dmac, null: false

      t.timestamps
    end
    # add_index :dsts, [:port, :ip, :mac], unique: true
  end
end
