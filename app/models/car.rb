class Car < ApplicationRecord
  belongs_to :manufacturer
  
  validates_presence_of :manufacturer, :color, :year, :mileage
  validates :year, numericality: { greater_than_or_equal_to: 1920 }
end
