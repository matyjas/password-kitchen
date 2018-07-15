use Mix.Config

port =
  case System.get_env("PORT") do
    port when is_binary(port) ->
      String.to_integer(port)

    nil ->
      80
  end

telegram_token =
  case System.get_env("TELEGRAM_TOKEN") do
    token when is_binary(token) ->
      token
    nil ->
      "NO_TOKEN_4_TELEGRAM"
      

# Pull Telegram token
config :password_kitchen, telegram_token: telegram_token

config :password_kitchen, port: port
