#app.rb
require "sinatra"
require "sinatra/activerecord"

set :database_file, 'config/database.yml'
set :public_folder, File.join(File.dirname(__FILE__), "public")


require File.expand_path(File.join('controllers', 'mains_controller'))
require File.expand_path(File.join('models', 'users'))

Dir[File.join('controllers', '**/*._controller.rb')].each { |file| require File.expand_path(file)}
Dir[File.join('models', '**/*.rb')].each { |file| require File.expand_path(file)}

# set :database, ""