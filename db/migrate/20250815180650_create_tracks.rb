class CreateTracks < ActiveRecord::Migration[8.0]
  def change
    create_table :tracks, id: :uuid do |t|
      t.integer :index
      t.string :name

      t.timestamps
    end
  end
end
