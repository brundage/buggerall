BuggerallConfig.configure do |c|
   c.image = ChunkyPNG::Image.from_file(File.join(Rails.root,"public","buggerall.png"))
end
