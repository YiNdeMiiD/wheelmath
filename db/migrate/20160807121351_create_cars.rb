class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string  :number
      t.text    :description
      t.boolean :is_free
      t.float   :pos_long
      t.float   :pos_lat
      t.timestamps null: false
    end
  end
end
