class Figure < Chunk
  def content_to_html
    a = self.content.split("|")
    "<strong>Figure #{a[0]}.</strong> #{a[1]}".html_safe
  end
end
