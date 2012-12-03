cli_opts = File.read(".rspec").split(/\n/).join(" ")

guard 'rspec', :cli => cli_opts do

  watch( %r{^spec/cases/.+_spec\.rb$} )

  watch( %r{^(lib/.+)\.rb$} ) { |m| "spec/cases/#{m[1]}_spec.rb" }

  watch( %r{^(app/.+)\.rb$} ) { |m| "spec/cases/#{m[1]}_spec.rb" }

end
