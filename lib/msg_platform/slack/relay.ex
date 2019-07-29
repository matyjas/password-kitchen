defmodule MsgPlatform.Slack.Relay do
  @moduledoc "Relays messages from Slack to generic conversation system"

  def forward(msg = %{"type" => "url_verification"}) do
    # save the token for later verification
    msg["challenge"]
  end

  def forward(message) do
    "thanks"
  end
end
