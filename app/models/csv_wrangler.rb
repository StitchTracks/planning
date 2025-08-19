class CsvWrangler
  require "csv"

  def write_all_data_to_db
    write_data_from_csv("PoK_items.csv")
  end

  def write_some_data_to_db
    write_data_from_csv("PoK_some_items.csv")
  end

  def clear_csv_data_from_db
    n = 6
    while n > 0
      PokItem.where(level: n).all.each do |item|
        item.destroy
      end
      n -= 1
    end
  end

  private
    def write_data_from_csv(filename)
      csv_text = File.read(Rails.root.join("lib/data/#{filename}"))
      csv = CSV.parse(csv_text, headers: true, encoding: "ISO-8859-1")

      current_item_ids = Array.new

      csv.each do |row|
        item_level = row["level"].to_i
        parent_item_level = item_level - 1
        parent_item_id = current_item_ids[parent_item_level]
        pok_item = PokItem.create!(
          level: item_level,
          name: row["name"],
          description: row["description"],
          page: row["page"].to_i,
          sequence: row["sequence"].to_i,
          parent_item_id: parent_item_id
        )
        current_item_ids[item_level] = pok_item.id
      end
    end
end
