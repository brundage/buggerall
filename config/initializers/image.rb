BuggerallConfig.configure do |c|
   c.image = ChunkyPNG::Image.from_file(File.join(Rails.root,"public","buggerall.png"))
   c.image_blob = c.image.to_blob
end
