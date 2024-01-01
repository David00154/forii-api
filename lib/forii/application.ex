defmodule Forii.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ForiiWeb.Telemetry,
      Forii.Repo,
      {DNSCluster, query: Application.get_env(:forii, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Forii.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Forii.Finch},
      # Start a worker by calling: Forii.Worker.start_link(arg)
      # {Forii.Worker, arg},
      # Start to serve requests, typically the last entry
      ForiiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Forii.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ForiiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
