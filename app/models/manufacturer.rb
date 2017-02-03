class Manufacturer < ApplicationRecord
  has_many :cars
  
  validates_presence_of :name, :country
end
