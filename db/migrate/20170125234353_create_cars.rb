class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.belongs_to :manufacturer, null: false
      t.string :color, null: false
      t.integer :year, null: false
      t.integer :mileage, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
