defmodule Edge.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Edge.Router

  @opts Router.init([])

  test "everything is OK" do

    conn = conn(:get, "/api/diag/v1/ok")
    conn = Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "ok"
  end
end
