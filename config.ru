#require main application file and define the Rack application to run your Sinatraa app

require './app'
#require File.join(File.dirname(__FILE__), 'app.rb')
map('/') { run MainController }
run Sinatra::Application
