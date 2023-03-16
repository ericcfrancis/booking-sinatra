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

    ## USER START ##

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
        password = params[:password]
        # role = params[:role]

        user = User.new(username: username, password:password)

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
            @rooms = Room.all
            erb :home
        else
            redirect '/'
        end
    end

    #go to edit profile form
    get '/edit/:id' do
        @users = User.where(id: session[:user_id])
        erb :edit
    end

    #update profile
    post '/update/:id' do
        username = params[:username]
        password = params[:password]
        user_id = params[:id]        

        user = User.find_by(id: user_id)

        if user.update(username: username, password: password)
            if user.role
                redirect '/admin'
            else
                redirect '/home'
            end
        else            
            erb :error, locals: { message: 'Failed to update profile' }
        end
    end

    #delete profile
    delete '/delete/:id' do
        @user = User.find(params[:id])
        @user.destroy
        redirect'/'
    end

    ##USER END ##
    

    #ROOM START ##
    
    #add room form
    get '/add_room' do
        erb :add_room
    end

    #create room
    post '/add' do
        room_name = params[:room_name]
        rate = params[:rate]
        capacity = params[:capacity]

        room = Room.new(room_name: room_name, rate: rate, capacity:capacity)

        room.save
        redirect '/admin'
    end

    #view rooms
    get '/room_list' do
        @rooms = Room.all
        erb :room_list
    end

    ##ROOM END ##

    
    ##BOOKING START ##

    #user booking page
    get '/book_room/:id' do
        @room = Room.find(params[:id])
        erb :book_room
    end

    ##BOOKING END ##
    
end