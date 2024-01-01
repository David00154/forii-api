defmodule ForiiWeb.Router do
  use ForiiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
  end

  scope "/api", ForiiWeb do
    pipe_through :api

    scope "/auth", Accounts, as: :accounts do
      post "/create_account", AuthController, :create
      post "/login", AuthController, :login
      post "/verify_code", AuthController, :verify
      post "/refresh", AuthController, :refresh
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:forii, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ForiiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
