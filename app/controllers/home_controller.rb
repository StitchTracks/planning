class HomeController < ApplicationController
require "csv"
  def index
    # csvw = CsvWrangler.new
    # csvw.clear_csv_data_from_db
    # csvw.write_all_data_to_db

    @read_lines = Array.new

    contents = CSV.open "ALL_DATA.csv", headers: true, header_converters: :symbol

    contents.each do |row|
      index = row[:index]
      name = row[:name]
      description = row[:description]
      @read_lines << "At #{index}, we have #{name} (#{description})"
    end
  end
end
