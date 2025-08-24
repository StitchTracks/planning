module BugHelper
  def buggly_this(str)
    File.open("buggly.txt", "w") { |file| file.write(str) }
  end
end
