defmodule Edge.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Edge.Router

  @opts Router.init([])

  test "everything is OK" do
    conn = conn(:get, "/api/diag/v1/ok")
    |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "ok"
  end

  test "telegram edge" do
    conn = conn(:post, "/api/telegram/v1")
    |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "ok"
  end

  test "slack handshake" do

    challenge = "3eZbrw1aBm2rZgRNFdxV2595E9CY3gmdALWMmHkvFXO7tYXAYM8P"
    sample_body_string = "{\"token\": \"Jhj5dZrVaK7ZwHHjRyZWjbDl\", \"challenge\": \"3eZbrw1aBm2rZgRNFdxV2595E9CY3gmdALWMmHkvFXO7tYXAYM8P\", \"type\": \"url_verification\"}"

    conn = conn(:post, "/api/slack/v1", sample_body_string)
    |> put_req_header("content-type", "application/json")
    |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == challenge
  end

  @sample_reaction_added "{\"token\": \"z26uFbvR1xHJEdHE1OQiO6t8\", \"team_id\": \"T061EG9RZ\", \"api_app_id\": \"A0FFV41KK\", \"event\": { \"type\": \"reaction_added\", \"user\": \"U061F1EUR\", \"item\": { \"type\": \"message\", \"channel\": \"C061EG9SL\", \"ts\": \"1464196127.000002\" }, \"reaction\": \"slightly_smiling_face\", \"item_user\": \"U0M4RL1NY\", \"event_ts\": \"1465244570.336841\" }, \"type\": \"event_callback\", \"authed_users\": [ \"U061F7AUR\" ], \"event_id\": \"Ev9UQ52YNA\",\"event_time\": 1234567890}"
  
  test "not slack handshake" do
    conn = conn(:post, "/api/slack/v1", @sample_reaction_added)
    |> put_req_header("content-type", "application/json")
    |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "thanks"    
  end
end
