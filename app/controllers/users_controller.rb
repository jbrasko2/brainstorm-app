class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            flash[:message] = "Signed in as #{current_user.username}."
            redirect to '/ideas'
        end
    end

    post '/signup' do
        @user = User.new(username: params[:username], password: params[:password])
        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Welcome to BrainStorm, #{@user.username}!"
            redirect to '/ideas'
        else
            flash[:messages] = @user.errors.full_messages
            redirect to '/signup'
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
