#
# require_relative '../models/room'exit


class MainController < Sinatra::Base

    # Set public folder for static files
    set :public_foler, File.expand_path('../../public',__FILE__)

    # set  folder for templates to ../views, but make the path absolute
    set :views, File.expand_path('../../views', __FILE__)

    enable :sessions

    get '/' do
        # 'ello'
        erb :index
    end

    #CREATE
    post '/room' do
        #retrieve data
        room_name = params[:room_name]
        room_rate = params[:room_rate]
        room_capacity = params[:room_capacity]
        # debug

        #
        @room = Room.new(room_name: room_name, room_rate: room_rate, room_capacity: room_capacity)

        @room.save
    end

    # get '/users' do
    #     erb :users
    # end
end