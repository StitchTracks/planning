class AddDoneToPokItems < ActiveRecord::Migration[8.0]
  def change
    add_column :pok_items, :done, :boolean, default: false
  end
end
