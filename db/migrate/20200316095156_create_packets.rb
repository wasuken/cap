class CreatePackets < ActiveRecord::Migration[6.0]
  def change
    create_table :packets do |t|
      t.integer :dst_id
      t.integer :src_id
      t.string :iface_name
      t.string :content

      t.timestamps
    end
  end
end
