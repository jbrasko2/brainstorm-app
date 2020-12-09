class SessionsController < ApplicationController

    get '/login' do
        if !logged_in?
            erb :'sessions/login'
        else
            redirect to '/ideas'
        end
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          flash[:message] = "Welcome, #{@user.username}!"
          redirect to '/ideas'
        else
            flash[:message] = "Username or Password not recognized. Try again or choose 'Sign Up' below."
            redirect to '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/'
        else
            redirect to '/'
        end
    end

    

end