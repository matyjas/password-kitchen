defmodule Dialog.Convo do
  use GenServer

  @moduledoc """
  holds a conversation with an end user, messaging platform agnostic
  """

  # public

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @spec put_message(term, term, term, term) :: term
  def put_message(pid, message, parser, gateway) do
    GenServer.cast(pid, {:put, message, parser, gateway})
  end

  def get_messages(pid) do
    GenServer.call(pid, :get)
  end

  # otp callbacks

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:put, message, parser, gateway}, state) do
    utterance = parser.extract_utterance(message)
    sender_id = parser.extract_sender_id(message)

    gateway.send_password(sender_id, "password")

    {:noreply, [utterance | state]}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end
end
