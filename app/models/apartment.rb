class Apartment < ActiveRecord::Base
  has_many :reviews
  belongs_to :user
end
