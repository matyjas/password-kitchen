defmodule Support.Dialog.StubMessage do
  @behaviour Dialog.Message

  @moduledoc """
  A simple Message implementation for use in tests as a stub
  """

  def extract_sender_id(id), do: {:ok, id}
  def extract_date(date), do: {:ok, date}
  def extract_utterance(message), do: {:ok, message}
end
