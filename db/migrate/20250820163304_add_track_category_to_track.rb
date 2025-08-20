class AddTrackCategoryToTrack < ActiveRecord::Migration[8.0]
  def change
    add_reference :tracks, :track_category, null: true, type: :uuid, foreign_key: true
  end
end
