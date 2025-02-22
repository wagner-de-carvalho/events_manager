defmodule EventsWeb.Router do
  use EventsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EventsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventsWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", EventsWeb do
    pipe_through :api

    post "/events", EventsController, :create
    get "/events", EventsController, :list
    get "/events/:pretty_name", EventsController, :get_by_pretty_name

    post "/subscriptions/:pretty_name", SubscriptionsController, :create
    post "/subscriptions/:pretty_name/:indication_user_id", SubscriptionsController, :create
    get "/subscriptions/:pretty_name/ranking", SubscriptionsController, :ranking
    get "/subscriptions/:pretty_name/ranking/:user_id", SubscriptionsController, :ranking_by_user
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:events, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EventsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
