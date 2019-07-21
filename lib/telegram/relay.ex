defmodule Telegram.Relay do
  @moduledoc "Relays messages from Telegram to generic conversation components."

  alias Dialog.Convo
  alias Telegram.{Gateway, Update}

  @doc """
  Forwards update message to `Dialog.Convo` associated with sender.

  Decorates message from Telegram with implementations of 
  - `Dialog.Message`
  - `Dialog.Gateway`
  """
  def forward(update) do
    with {:ok, sender} <- Update.extract_sender_id(update),
         via <- via_tuple(sender) do
      child_spec = Convo.child_spec(name: via)
      # may already be started
      DynamicSupervisor.start_child(DynamicSupervisor.Convo, child_spec)
      Convo.put_message(via, update, Update, Gateway)
    else
      {:error, :unexpected_message} ->
        IO.puts("cannot forward telegram message")
    end
  end

  @doc "Returns registered name for this sender/conversation"
  def via_tuple(sender) do
    {:via, Registry, {Registry.Convo, "telegram::" <> to_string(sender)}}
  end
end
