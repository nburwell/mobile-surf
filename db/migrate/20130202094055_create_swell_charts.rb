class CreateSwellCharts < ActiveRecord::Migration
  def change
    create_table :swell_charts do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :url

      t.timestamps
    end
  end
end
