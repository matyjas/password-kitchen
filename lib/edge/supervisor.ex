defmodule Edge.Supervisor do
  use Supervisor
  @moduledoc "encapsulates config of plug/cowboy"

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts)
  end

  def init(_opts) do
    alias Plug.Adapters.Cowboy
    alias Edge.Router
      
    port = Application.fetch_env!(:password_kitchen, :port)

    children = [
      Cowboy.child_spec(scheme: :http, plug: Router, options: [port: port])
    ]

    opts = [strategy: :one_for_one]

    Supervisor.init(children, opts)
  end
end
