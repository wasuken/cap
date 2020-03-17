class NetPacket < ApplicationRecord
  belongs_to :src
  belongs_to :dst
end
