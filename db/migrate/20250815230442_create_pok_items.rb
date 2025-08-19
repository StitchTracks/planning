class CreatePokItems < ActiveRecord::Migration[8.0]
  def change
    create_table :pok_items, id: :uuid do |t|
      t.integer :level
      t.string :name
      t.string :description
      t.integer :page
      t.integer :sequence
      t.references :parent_item, type: :uuid, foreign_key: { to_table: :pok_items }
      t.references :section, null: true, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
