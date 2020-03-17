class CreateSrcs < ActiveRecord::Migration[6.0]
  def change
    create_table :srcs do |t|
      t.integer :sport
      t.string :sip
      t.string :smac

      t.timestamps
    end
    # add_index :srcs, [:port, :ip, :mac], unique: true
  end
end
