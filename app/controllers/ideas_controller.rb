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
        redirect to '/ideas/new'
      else
        @idea = current_user.ideas.build(title: params[:title], content: params[:content])
        @idea.save
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
        redirect to '/ideas'
      end
    else
      redirect to '/login'
    end
  end

  get "/ideas/:id/edit" do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea
        erb :'ideas/edit'
      else
        redirect to '/ideas'
      end
    else
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
          redirect to "/ideas/#{@idea.id}"
        else
          redirect to "/ideas/#{@idea.id}/edit"
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/ideas/:id/delete' do
    if logged_in?
      @idea = current_user.ideas.find_by_id(params[:id])
      if @idea
        @idea.delete
      end
      redirect to '/ideas'
    else
      redirect to '/login'
    end
  end
end
