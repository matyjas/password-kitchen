defmodule Telegram.GatewayTest do
  use ExUnit.Case, async: true

  alias Telegram.{Gateway}
  alias Kitchen.Oven
  @maciej_id 228303213

  test "send message to maciej" do
    {:ok, pid} = Gateway.start_link([])
    resp = Gateway.send_message pid, @maciej_id, "send test working"
    assert resp != nil
  end

  test "gateway is transient" do
    # testing under the client API
    response = Gateway.handle_cast({:send_message,
				    @maciej_id,
				    "transient test in progress"}, {})
    assert response == {:stop, :normal, {}}
  end

  test "send password" do
    psswd = Oven.bake()
    response = Gateway.handle_cast({:send_password,
				    @maciej_id,
				    psswd}, {})
    assert response == {:stop, :normal, {}}
  end

  test "encode message for telegram" do
    msg_body = Gateway.encode_message(1, "message text")
    assert msg_body != nil
  end
end
