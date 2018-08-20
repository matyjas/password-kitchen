defmodule Dialog.Supervisor do
  use Supervisor
  @moduledoc "maintains processes associated with ongoing dialogs"

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts)
  end

  def init(_opts) do
    opts = [strategy: :one_for_all]
    children = [
      {Registry, keys: :unique, name: Registry.Convo},
      {DynamicSupervisor, strategy: :one_for_one, name: DynamicSupervisor.Convo}
    ]

    Supervisor.init(children, opts)
  end
  
end
