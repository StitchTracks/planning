class Aside < Chunk
  def content_to_html
    self.content.html_safe
  end
end
