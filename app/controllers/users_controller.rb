class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to '/ideas'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.new(username: params[:username], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/ideas'
        end
    end

    get '/users/:slug' do
        @ideas = Idea.all
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
end

end
