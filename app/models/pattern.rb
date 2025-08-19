class Pattern < Chunk
  def content_to_html
    s = self.content
    s.gsub! "<div>", "<table class=\"pattern-table\"><tr><td>"
    s.gsub! "</div>", "</td></tr></table>"
    s.gsub! "<br>", "</td></tr><tr><td>"
    s.gsub! " ----- ", "</td><td>"
    s.html_safe
  end
end
