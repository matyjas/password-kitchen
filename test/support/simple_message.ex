defmodule Dialog.TestUtils.SimpleMessage do
  @behaviour Dialog.Message

  def extract_sender_id(id), do: id
  def extract_date(date), do: date
  def extract_utterance(message), do: message

end
