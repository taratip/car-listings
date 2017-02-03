class AddConditionToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :condition, :string, null: false, default: ''
  end
end
