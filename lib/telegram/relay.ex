defmodule Telegram.Relay do
  @moduledoc """
  Relays messages from Telegram to generic conversation components. 
  Adds Telegram specific message parser and gateway.
  """

  alias Dialog.Convo
  alias Telegram.{Update, Gateway}

  def forward(update) do
    with {:ok, sender} <- Update.extract_sender_id(update),
	 via <- via_tuple(sender)
      do
        Convo.start_link(name: via) # may already be started
        Convo.put_message(via, update, Update, Gateway)
      else
	{:error, :unexpected_message} ->
	  IO.puts("cannot forward telegram message")
    end
  end

  def via_tuple(sender) do
    {:via, Registry, {Registry.Convo, "telegram::" <> to_string(sender)}}
  end
end
