guard 'rails_best_practices' do
  watch(%r{^app/(.+)\.rb$})
end

guard 'rspec', all_after_pass: false do

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/factories/(.+).rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }

  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }

  watch(%r{^app/(.*)(\.erb|\.haml)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }

  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }

  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }

  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

end

