class Packet < ApplicationRecord
  has_one :srcs
  has_one :dsts
end
