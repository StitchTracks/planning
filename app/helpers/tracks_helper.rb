module TracksHelper
  def default_track_id
    default_track = Track.find_by(name: "Master")
    default_track.id
  end
end
