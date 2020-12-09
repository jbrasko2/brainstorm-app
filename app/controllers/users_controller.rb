class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            @user = current_user
            flash[:message] = "Signed in as #{@user.username}."
            redirect to '/ideas'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == ""
            flash[:message] = "Username and Password fields cannot be blank!"
            redirect to '/signup'
        else
            @user = User.new(username: params[:username], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            flash[:message] = "Welcome to BrainStorm, #{@user.username}!"
            redirect to '/ideas'
        end
    end

    get '/users' do
        @users = User.all
        erb :'users/index'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

end
