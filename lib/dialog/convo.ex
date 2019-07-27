defmodule Dialog.Convo do
  use GenServer, restart: :transient

  @moduledoc """
  A `GenServer` that holds conversation history of an end user in each instance. 

  State is a list of past utterances from the end user.
  It is messaging platform agnostic.
  If state is an empty list, responses to gateway include onboarding.
  """

  alias Dialog.Onboarding
  alias Kitchen.Oven

  # public

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Async delivery of new message from an end user.

  Details of the messaging platform are abstracted behind `message`, `parser` and `gateway`.
  `message` is the **full raw message** sent from messaging platform. 
  `parser` implements callbacks in `Dialog.Message`. 
  `gateway` implements callbacks in `Dialog.Gateway`. 
  Depending on content of message and local state, different outbound messages are sent via `gateway`. 
  """
  @spec put_message(pid, String.t(), String.t(), term) :: term
  def put_message(pid, utterance, sender_id, gateway) do
    GenServer.call(pid, {:put_msg, utterance, sender_id, gateway})
  end
  #  def put_message(pid, message, parser, gateway) do
#    GenServer.cast(pid, {:put, message, parser, gateway})
#  end


  
  @doc """
  Synchronous request to return list of utterances collected in state.

  Returns `{:ok, []}`.
  """
  @spec get_messages(pid) :: term
  def get_messages(pid) do
    GenServer.call(pid, :get)
  end

  # otp callbacks

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:put, message, parser, gateway}, [] = state) do
    new_state =
      with {:ok, utterance} <- parser.extract_utterance(message),
           {:ok, sender_id} <- parser.extract_sender_id(message),
           {:ok, date} <- parser.extract_date(message),
           {:ok, pid} <- gateway.start_link([]) do
        password = Oven.bake()
        onboarding = Onboarding.get(date)
        gateway.send_onboarding(pid, sender_id, onboarding, password)
        [utterance | state]
      else
        _ ->
          state
      end

    {:noreply, new_state}
  end

  def handle_cast({:put, message, parser, gateway}, state) do
    new_state = send_password(message, parser, gateway, state)
    {:noreply, new_state}
  end

  def handle_call({:put_msg, utterance, sender_id, gateway}, _from, state) do
    {:ok, pid} = gateway.start_link([])
    password = Oven.bake() 
    gateway.send_password(pid, sender_id, password)
    {:reply, :ok, [utterance | state]}
  end
  
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  # private
  defp send_password(message, parser, gateway, state) do
    with {:ok, utterance} <- parser.extract_utterance(message),
         {:ok, sender_id} <- parser.extract_sender_id(message),
         {:ok, pid} <- gateway.start_link([]),
         password <- Oven.bake() do
      gateway.send_password(pid, sender_id, password)
      [utterance | state]
    else
      _ ->
        state
    end
  end
end
