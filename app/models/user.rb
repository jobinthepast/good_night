class User < ApplicationRecord
  has_many :followings,  dependent: :destroy
  has_many :sleeps, dependent: :destroy
end
