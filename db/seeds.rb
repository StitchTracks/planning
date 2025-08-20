subject_items = Array.new

subject_items << { "name" => "Kutovakika thumb purl", "description" => "https://youtu.be/b7m0pl10fFA?si=HAz7HO2iZT2XiSzM" }
subject_items << { "name" => "Ladderback jaquard", "description" => "https://www.youtube.com/watch?v=UcQns-ON1nw" }
subject_items << { "name" => "iCord", "description" => "https://nimble-needles.com/stitches/how-to-knit-an-i-cord-for-beginners/" }
subject_items << { "name" => "Roxanne Richardson purl", "description" => "https://youtu.be/pbN1Rq2YFn0?si=qHjYKAAsoWVQmZF7" }

seq = 1
subject_items.each do |si|
  subject_item = SubjectItem.find_by(name: si["name"])
  if subject_item
    subject_item.update(
      description: si["description"],
      sequence: seq
    )
  else
    SubjectItem.create(
      level: 1,
      name: si["name"],
      description: si["description"],
      sequence: seq,
      parent_item: nil,
      section: nil
    )
  end
  seq += 1
end
