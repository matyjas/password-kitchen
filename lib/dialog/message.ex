defmodule Dialog.Message do
  @moduledoc """
  Generic message behaviour, abstracts platform specifics
  """

  @type helpful_response :: {:ok, String.t()} | {:error, String.t()}

  @callback extract_sender_id(any) :: helpful_response
  @callback extract_date(any) :: helpful_response
  @callback extract_utterance(any) :: helpful_response
end
