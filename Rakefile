require_relative './config/environment'

def reload!
  load_all "./config" if Dir.exists?("./config")
  load_all "./app" if Dir.exists?("./app")
  load_all "./lib" if Dir.exists?("./lib")
  load_all "./*.rb" if Dir.entries(".").include?(/\.rb/)
end

task :console do
  puts "Loading your application environment..."
  reload!
  puts "Console started:"
  Pry.start
end

task :generate_site do
  MusicImporter.new("./db/mp3s").import
  SiteGenerator.new("_site").call
end
