class CreateChunks < ActiveRecord::Migration[8.0]
  def change
    create_table :chunks, id: :uuid do |t|
      t.string :type
      t.references :section, null: false, foreign_key: true, type: :uuid
      t.integer :index
      t.text :content

      t.timestamps
    end
  end
end
