class CreateSrcs < ActiveRecord::Migration[6.0]
  def change
    create_table :srcs do |t|
      t.integer :sport, null: false
      t.string :sip, null: false
      t.string :smac, null: false

      t.timestamps
    end
    # add_index :srcs, [:port, :ip, :mac], unique: true
  end
end
