class CreateTrackCategory < ActiveRecord::Migration[8.0]
  def change
    create_table :track_categories, id: :uuid do |t|
      t.integer :index
      t.string :name

      t.timestamps
    end
  end
end
