$:.push File.expand_path("../lib", __FILE__)

require "buggerall/version"

Gem::Specification.new do |s|
  s.name        = "buggerall"
  s.version     = Buggerall.version
  s.authors     = ["Dean Brundage"]
  s.email       = ["dean@deanbrundage.com"]
  s.homepage    = "http://github.com/brundage/buggerall"
  s.summary     = "TODO: Summary of Buggerall."
  s.description = "TODO: Description of Buggerall."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'chunky_png'
  s.add_dependency "rails", "> 3.1.0"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"

end
