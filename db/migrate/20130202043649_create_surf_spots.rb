class CreateSurfSpots < ActiveRecord::Migration
  def change
    create_table :surf_spots do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.string :msw_id
      t.string :msw_name
      t.string :address

      t.timestamps
    end
  end
end
