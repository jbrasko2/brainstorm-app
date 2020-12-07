class IdeasController < ApplicationController

  get "/ideas" do
    erb :"/ideas/index.html"
  end

  get "/ideas/new" do
    erb :"/ideas/new.html"
  end

  post "/ideas" do
    redirect "/ideas"
  end

  get "/ideas/:id" do
    erb :"/ideas/show.html"
  end

  get "/ideas/:id/edit" do
    erb :"/ideas/edit.html"
  end

  patch "/ideas/:id" do
    redirect "/ideas/:id"
  end

  delete "/ideas/:id/delete" do
    redirect "/ideas"
  end
end
