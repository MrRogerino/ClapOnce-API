class CreateIncidents < ActiveRecord::Migration[5.0]
  def change
    create_table :incidents do |t|
      t.string  :type
      t.string  :severity 
      t.decimal :latitude, precision: 8, scale: 5, default: 0
      t.decimal :longitude, precision: 8, scale: 5, default: 0

      t.timestamps
    end
  end
end
