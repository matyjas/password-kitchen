defmodule Edge.Supervisor do
  use Supervisor
  @moduledoc "encapsulates config of plug/cowboy"

  alias Plug.Adapters.Cowboy
  alias Edge.Router

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    port = Application.fetch_env!(:password_kitchen, :port)

    children = [
      Cowboy.child_spec(scheme: :http, plug: Router, options: [port: port])
    ]

    opts = [strategy: :one_for_one]

    Supervisor.init(children, opts)
  end
end
