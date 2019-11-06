class User < ApplicationRecord
  has_many :followings,  dependent: :destroy
  has_many :clocked_ins, dependent: :destroy
end
