class CreateSurfSpots < ActiveRecord::Migration
  def change
    create_table :surf_spots do |t|
      t.string :lat
      t.string :long
      t.string :name
      t.string :msw_id
      t.string :msw_name

      t.timestamps
    end
  end
end
