defmodule Edge.Router do
  use Plug.Router
  @moduledoc "HTTP entry point for Password Kitchen"

  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  get "/api/diag/v1/ok" do
    send_resp(conn, 200, "ok")
  end

  post "/api/telegram/v1" do
    MsgPlatform.Telegram.Relay.forward(conn.params)
    send_resp(conn, 200, "ok")
  end

  post "/api/slack/v1" do
    resp = MsgPlatform.Slack.Relay.forward(conn.body_params)
    send_resp(conn, 200, resp)
  end
  
  match _ do
    send_resp(conn, 404, "oooops")
  end
end
