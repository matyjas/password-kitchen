defmodule Telegram.Token do
  @moduledoc """
  Encapsulates token for auth with Telegram, pulled from environment var
  """

  @telegram_token Application.get_env(
                    :password_kitchen,
                    :telegram_token,
                    "DEFAULT_TELEGRAM_TOKEN"
                  )

  def value, do: @telegram_token
end
