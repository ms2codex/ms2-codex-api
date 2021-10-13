defmodule CodexWeb.Router do
  use CodexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CodexWeb do
    pipe_through :api

    get "/item-categories", ItemController, :categories

    resources "/items", ItemController, only: [:index, :show]
  end
end
