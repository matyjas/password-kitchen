defmodule Dialog.SimpleMessage do
  @behaviour Dialog.Message

  def extract_utterance(message), do: message
end
