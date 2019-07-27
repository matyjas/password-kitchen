defmodule Telegram.Update do

  @moduledoc "Parses Update messages from Telegram"

  @typedoc """
  Return type for all functions in `Telegram.Update`.

  Each function returns either `:ok` and part of the message as a `t:String.t`
  or `:error` and an error message from the parser.
  """
  @type helpful_response :: {:ok, String.t()} | {:error, String.t()}

  @doc """
  Returns an id parsed from message. 

  The returned id is used to address messages sent back to the user.
  """
  @spec extract_sender_id(any) :: helpful_response
  def extract_sender_id(%{"message" => %{"chat" => %{"id" => sender}}}) do
    {:ok, sender}
  end

  def extract_sender_id(update), do: unknown_message_format(update)

  @doc """
  Returns date parsed from message.

  The returned date is used for additional randomness.
  """
  @spec extract_date(any) :: helpful_response
  def extract_date(%{"message" => %{"date" => date}}) do
    {:ok, date}
  end

  def extract_date(update), do: unknown_message_format(update)

  @doc """
  Returns text typed and sent by end user.

  The utterance is further processed to understand the intent of the end user
  and hopefully the correct next action.
  """
  @spec extract_utterance(any) :: helpful_response
  def extract_utterance(%{"message" => %{"text" => text}}) do
    {:ok, text}
  end

  def extract_utterance(update), do: unknown_message_format(update)

  defp unknown_message_format(_update) do
    # IO.puts("WARNING :: unhandled update from Telegram")
    # IO.puts update
    {:error, :unexpected_message}
  end
end
