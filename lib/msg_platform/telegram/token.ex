defmodule MsgPlatform.Telegram.Token do
  @moduledoc "Encapsulates token for auth with Telegram, pulled from environment var"

  @telegram_token Application.get_env(
                    :password_kitchen,
                    :telegram_token,
                    "DEFAULT_TELEGRAM_TOKEN"
                  )

  @doc """
  returns token for sending messages to Telegram

  Token source from ENV variable.

  ## Examples
      iex> MsgPlatform.Telegram.Token.value()
      "TESTING_TELEGRAM_TOKEN" 
  """
  def value, do: @telegram_token
end
