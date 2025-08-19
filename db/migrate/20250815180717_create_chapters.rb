class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters, id: :uuid do |t|
      t.integer :index
      t.string :name
      t.references :track, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
