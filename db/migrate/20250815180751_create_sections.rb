class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections, id: :uuid do |t|
      t.integer :index
      t.string :name
      t.references :chapter, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
