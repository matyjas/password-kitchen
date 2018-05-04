defmodule PK.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc "the main OTP application for password-kitchen"

  use Application

  # extract Cowboy and Router into another app
  alias Plug.Adapters.Cowboy
  alias Edge.Router

  def start(_type, _args) do

    port = Application.fetch_env!(:password_kitchen, :port)
    
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: PK.Worker.start_link(arg)
      # {PK.Worker, arg},
      Cowboy.child_spec(scheme: :http, plug: Router, options: [port: port])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PK.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
