defmodule Telegram.Update do
  @behaviour Dialog.Message

  @moduledoc "Implements `Dialog.Message` for Update messages from Telegram"
  
  def extract_sender_id(%{"message" => %{"chat" => %{"id" => sender}}}) do
    {:ok, sender}
  end

  def extract_sender_id(update), do: unknown_message_format(update)

  def extract_date(%{"message" => %{"date" => date}}) do
    {:ok, date}
  end

  def extract_date(update), do: unknown_message_format(update)

  def extract_utterance(%{"message" => %{"text" => text}}) do
    {:ok, text}
  end

  def extract_utterance(update), do: unknown_message_format(update)

  defp unknown_message_format(_update) do
    #IO.puts("WARNING :: unhandled update from Telegram")
    # IO.puts update
    {:error, :unexpected_message}
  end
end
