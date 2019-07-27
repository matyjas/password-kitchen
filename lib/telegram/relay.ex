defmodule Telegram.Relay do
  @moduledoc "Relays messages from Telegram to generic conversation components."

  alias Dialog.Convo
  alias Telegram.{Gateway, Update}

  @doc """
  Forwards update messages to `Dialog.Convo` associated with sender.

  Extracts 
  - sender id
  - text of message as utterance

  If cannot extract utterance and sender id, then drop the message.

  Decorates message from Telegram with implementation of `Dialog.Gateway`
  """
  def forward(update) do
    with {:ok, sender} <- Update.extract_sender_id(update),
         {:ok, utterance} <- Update.extract_utterance(update),
           via <- via_tuple(sender),
           child_spec <- Convo.child_spec(name: via) do
      # may already be started
      DynamicSupervisor.start_child(DynamicSupervisor.Convo, child_spec)
      Convo.put_message(via, utterance, sender, Gateway)
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
