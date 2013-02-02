class AddAddressToSwellChart < ActiveRecord::Migration
  def change
    change_table :swell_charts do |t|
      t.string :address, :default => ""
    end
  end
end
