class AddMsWidgetEmbedToSurfSpot < ActiveRecord::Migration
  def change
    change_table :surf_spots do |t|
      t.string :msw_widget_embed, :default => "", :limit=>2000
    end
  end
end
