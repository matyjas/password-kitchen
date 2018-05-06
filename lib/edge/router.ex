defmodule Edge.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json], json_decoder: Jason
  plug(:match)
  plug(:dispatch)

  get "/api/diag/v1/ok" do
    send_resp(conn, 200, "ok")
  end

  post "/api/telegram/v1" do

    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oooops")
  end
end
