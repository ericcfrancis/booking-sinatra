#
# require_relative '../models/room'exit

class MainController < Sinatra::Base

    # Set public folder for static files
    set :public_folder, File.expand_path('../../public',__FILE__)

    # set  folder for templates to ../views, but make the path absolute
    set :views, File.expand_path('../../views', __FILE__)

    enable :sessions

    #index page
    get '/' do        
        erb :index
    end

    #login form
    post '/login' do
        username = params[:username]
        password = params[:password]

        user = User.find_by(username: username, password: password)

        if user
            session[:user_id] = user.id
            session[:logged_in] = true

            if user.role
                redirect '/admin'
            else
                redirect '/home'
            end
            
        else
            erb :index, locals:{error: 'Invalid'}
        end
    end

    #register form
    post '/register' do
        username = params[:username]
        role = params[:role]
        password = params[:password]

        is_admin = role == '1'

        user = User.new(username: username, role: role, password:password)

        user.save

        redirect '/'
    end

    #logout
    get '/logout' do
        session.clear
        redirect '/'
    end

    #register page
    get '/regpage' do
        erb :register
    end

    #admin page
    get '/admin' do
        if session[:logged_in]
          @users = User.where(id: session[:user_id])
        
          erb :admin
        else
          redirect '/'
        end
    end

    #user page
    get '/home' do
        if session[:logged_in]
            #find logged in user data
            @users = User.where(id: session[:user_id])
            erb :home
        else
            redirect '/'
        end
    end

    #go to edit profile form
    get '/edit' do
        @users = User.where(id: session[:user_id])
        erb :edit
    end

    #update profile
    post '/update' do
        username = params[:username]
        password = params[:password]
        user_id = params[:user_id]

        user = User.find_by(id: user_id)

        if user.update(username: username, password: password)
            if user.role
                redirect '/admin'
            else
                redirect '/home'
            end
        else
            # handle the case where the update was not successful
            erb :error, locals: { message: 'Failed to update profile' }
        end
    end
    # post '/update' do
    #     username = params[:username]
    #     password = params[:password]
    #     user_id = params[:user_id]

    #     user = User.where(id: user_id)

    #     user.update(username: username, password: password)

    #     if user.role
    #         redirect '/admin'
    #     else
    #         redirect '/home'
    #     end
    # end

    #CREATE
    post '/room' do
        #capture data input
        room_name = params[:room_name]
        room_rate = params[:room_rate]
        room_capacity = params[:room_capacity]
        
        #object room to save data input
        @room = Room.new(room_name: room_name, room_rate: room_rate, room_capacity: room_capacity)        
        @room.save
       
        begin
            @room.save!
            redirect '/'
          rescue ActiveRecord::RecordInvalid => e
            puts e.message
            redirect '/'
        end
    end
    
end