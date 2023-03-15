#app.rb
require "sinatra"
require "sinatra/activerecord"

set :database_file, 'config/database.yml'

require File.expand_path(File.join('controllers', 'mains_controller'))
require File.expand_path(File.join('models', 'room'))

Dir[File.join('controllers', '**/*._controller.rb')].each { |file| require File.expand_path(file)}
Dir[File.join('models', '**/*.rb')].each { |file| require File.expand_path(file)}

# set :database, ""