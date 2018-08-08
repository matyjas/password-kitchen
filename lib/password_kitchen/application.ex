defmodule PK.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc "the main OTP application for password-kitchen"

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: PK.Worker.start_link(arg)
      # {PK.Worker, arg},
      Edge.Supervisor,
      {Registry, keys: :unique, name: Registry.Convo}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
