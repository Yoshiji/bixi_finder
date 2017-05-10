class CreateBixiStations < ActiveRecord::Migration[5.1]
  def change
    create_table :bixi_stations do |t|
    	t.integer :official_identifier
    	t.string :name
    	t.string :terminal_identifier
    	t.decimal :latitude, { precision: 14, scale: 6 }
    	t.decimal :longitude, { precision: 14, scale: 6 }
      t.boolean :useable
      t.integer :available_bikes
      t.datetime :last_checked_at

      t.timestamps
    end
  end
end
