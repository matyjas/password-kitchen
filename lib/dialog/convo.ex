defmodule Dialog.Convo do
  use GenServer

  @moduledoc """
  holds a conversation with an end user, messaging platform agnostic
  """

  # public
  
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def new_message(pid, message, parser, gateway) do

  end

  # otp callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:new_message, message, parser, gateway}, state) do

    {:noreply, state}
  end
end
