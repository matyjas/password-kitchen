defmodule MsgPlatform.Slack.Token do
  @moduledoc "Token for Slack, pulled from env var"

  @slack_token Application.get_env(
    :password_kitchen,
    :slack_token,
    "DEFAULT_SLACK_TOKEN")

  @doc """
  Returns token for connecting to Slack.

  Token sourced from env var.

  ## Examples
      iex> MsgPlatform.Slack.Token.value()
      "TESTING_SLACK_TOKEN"
  """
  def value, do: @slack_token
end
