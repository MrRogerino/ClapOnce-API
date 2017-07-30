class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :status, default: "safe"
      t.decimal :latitude, precision: 8, scale: 5, default: 0
      t.decimal :longitude, precision: 8, scale: 5, default: 0

      t.timestamps
    end
  end
end
