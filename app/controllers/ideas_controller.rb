class IdeasController < ApplicationController

  get '/ideas' do
    if logged_in?
      @ideas = current_user.ideas
      erb :'ideas/index'
    else
      flash[:message] = "Please sign in to view your ideas."
      redirect to '/login'
    end
  end

  get '/ideas/new' do
    if logged_in?
      erb :'ideas/new'
    else
      flash[:message] = "Please sign in to add a new idea."
      redirect to '/login'
    end
  end

  post '/ideas' do
    if logged_in?
      @idea = current_user.ideas.build(title: params[:title], content: params[:content])
      if @idea.save
        flash[:message] = "Successfully added idea!"
        redirect to "/ideas/#{@idea.id}"
      else
        flash[:messages] = @idea.errors.full_messages
        redirect to '/ideas/new'
      end
    else
      flash = "Please sign in to add an idea."
      redirect to '/login'
    end
  end

  get '/ideas/:id' do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea
        erb :'ideas/show'
      else
        flash[:message] = "Idea does not exist!"
        redirect to '/ideas'
      end
    else
      flash[:message] = "Please sign in to see your ideas."
      redirect to '/login'
    end
  end

  get '/ideas/:id/edit' do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea
        erb :'ideas/edit'
      else
        flash[:message] = "That idea does not belong to you!"
        redirect to '/ideas'
      end
    else
      flash[:message] = "Please sign in to edit the idea."
      redirect to '/login' 
    end
  end

  patch '/ideas/:id' do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea.update(title: params[:title], content: params[:content])
        flash[:message] = "Successfully updated idea!"
        redirect to "/ideas/#{@idea.id}"
      else
        flash[:messages] = @idea.errors.full_messages
        redirect to "/ideas/#{@idea.id}/edit"
      end
    else
      flash[:message] = "Please sign in to edit the idea."
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
      flash[:message] = "Please sign in to delete the idea."
      redirect to '/login'
    end
  end
end
