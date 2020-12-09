

class IdeasController < ApplicationController

  get '/ideas' do
    if logged_in?
      @ideas = current_user.ideas
      erb :'ideas/index'
    else
      redirect to '/login'
    end
  end

  get "/ideas/new" do
    erb :'ideas/new'
  end

  post "/ideas" do
    if logged_in?
      if params[:title] == "" || params[:content] == ""
        flash[:message] = "Title and Content fields cannot be blank!"
        redirect to '/ideas/new'
      else
        @idea = current_user.ideas.build(title: params[:title], content: params[:content])
        @idea.save
        flash[:message] = "Successfilly added idea!"
        redirect to "/ideas/#{@idea.id}"
      end
    else
      redirect to '/login'
    end
  end

  get "/ideas/:id" do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea
        erb :'ideas/show'
      else
        flash[:message] = "Idea does not exist!"
        redirect to '/ideas'
      end
    else
      flash[:message] = "Please login to see your ideas."
      redirect to '/login'
    end
  end

  get "/ideas/:id/edit" do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea
        erb :'ideas/edit'
      else
        flash[:message] = "Idea does not exist!"
        redirect to '/ideas'
      end
    else
      flash[:message] = "Please login to edit this idea."
      redirect to '/login' 
    end
  end

  patch "/ideas/:id" do
    if logged_in?
      if params[:title] == "" || params[:content] == ""
        redirect to "/ideas/#{params[:id]}/edit"
      else
        @idea = current_user.ideas.find_by_id(params[:id])
        if @idea.update(title: params[:title], content: params[:content])
          flash[:message] = "Successfilly updated idea!"
          redirect to "/ideas/#{@idea.id}"
        else
          flash[:message] = "Oops! Edit failed to update!"
          redirect to "/ideas/#{@idea.id}/edit"
        end
      end
    else
      flash[:message] = "Please login to edit this idea."
      redirect to '/login'
    end
  end

  delete '/ideas/:id/delete' do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea
        @idea.delete
      end
      flash[:message] = "Idea has been deleted!"
      redirect to '/ideas'
    else
      flash[:message] = "Please sign in to delete this idea."
      redirect to '/login'
    end
  end
end
