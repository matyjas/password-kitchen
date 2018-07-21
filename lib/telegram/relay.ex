defmodule Telegram.Relay do
  @moduledoc """
  Relays messages from Telegram to generic conversation components. 
  Adds Telegram specific message parser and gateway.
  """

  alias Dialog.Convo
  alias Telegram.{Update, Gateway}

  def forward(update) do
    {:ok, pid} = Convo.start_link([])
    Convo.put_message(pid, update, Update, Gateway)
  end
end
