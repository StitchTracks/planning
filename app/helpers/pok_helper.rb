module PokHelper
  def default_chapter_id
    default_track = Track.find_by(name: "Stage 5")
    default_chapter = default_track.chapters.find_by(index: 0)
    default_chapter.id
  end
end
