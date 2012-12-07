namespace :db do
  desc "nuke all tables in database!"
  task :wipe => :environment do
    connection = ActiveRecord::Base.connection
    connection.tables.each do |table|
      begin
        connection.execute("drop table #{table} cascade")
        puts "Dropped table '#{table}'"
      rescue => e
        STDERR.puts e.message
        STDERR.puts e.backtrace
      end
    end
  end
end
