class User < ApplicationRecord
  has_one :ranking, foreign_key: :uid, primary_key: :uid
end
