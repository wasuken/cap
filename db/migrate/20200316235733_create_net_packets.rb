class CreateNetPackets < ActiveRecord::Migration[6.0]
  def change
    create_table :net_packets do |t|
      t.integer :dst_id, null: false
      t.integer :src_id, null: false
      t.integer :host_id, null: false
      t.string :packet_type, default: "tcp"
      t.string :iface_name, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
