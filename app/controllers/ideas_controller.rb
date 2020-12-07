class IdeasController < ApplicationController

  get "/ideas" do
    erb :"/ideas/index"
  end

  get "/ideas/new" do
    erb :"/ideas/new"
  end

  post "/ideas" do
    redirect "/ideas"
  end

  get "/ideas/:id" do
    erb :"/ideas/show"
  end

  get "/ideas/:id/edit" do
    erb :"/ideas/edit"
  end

  patch "/ideas/:id" do
    redirect "/ideas/:id"
  end

  delete "/ideas/:id/delete" do
    redirect "/ideas"
  end
end
