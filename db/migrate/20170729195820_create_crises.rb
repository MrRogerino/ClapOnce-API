class CreateCrises < ActiveRecord::Migration[5.0]
  def change
    create_table :crises do |t|

      t.timestamps
    end
  end
end
