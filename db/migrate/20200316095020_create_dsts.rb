class CreateDsts < ActiveRecord::Migration[6.0]
  def change
    create_table :dsts do |t|
      t.integer :dport
      t.string :dip
      t.string :dmac

      t.timestamps
    end
    # add_index :dsts, [:port, :ip, :mac], unique: true
  end
end
