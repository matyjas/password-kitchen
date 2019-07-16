defmodule Dialog.Message do
  @moduledoc """
  Generic message behaviour, abstracts platform specifics

  This behaviour is implemented for different message types 
  from different message platforms.
  The intention is to lazily avoid processing a message unless we need to,
  however this would be nicer as a series of closures hiding the raw message.
  """

  @typedoc """
  Return type for all functions in `Dialog.Message`.

  Each function returns either `:ok` and part of the message as a `t:String.t`
  or `:error` and an error message from the parser.
  """
  @type helpful_response :: {:ok, String.t()} | {:error, String.t()}

  @doc """
  Returns an id parsed from message. 

  The returned id is used to send messages back to the user.
  """
  @callback extract_sender_id(any) :: helpful_response

  @doc """
  Returns date parsed from message.

  The returned date is used for additional randomness.
  """
  @callback extract_date(any) :: helpful_response

  @doc """
  Returns text typed and sent by end user.

  The utterance is further processed to understand the intent of the end user
  and hopefully the correct next action.
  """
  @callback extract_utterance(any) :: helpful_response
end
