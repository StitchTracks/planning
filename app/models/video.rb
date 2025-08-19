class Video < Chunk
  def content_to_html
    "<strong>VIDEO</strong> #{self.content}".html_safe
  end
end
