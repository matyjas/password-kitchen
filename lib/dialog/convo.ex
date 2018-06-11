defmodule Dialog.Convo do
  use GenServer

  @moduledoc """
  holds a conversation with an end user, messaging platform agnostic
  """

  # public
  
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end
end
