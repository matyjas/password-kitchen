defmodule Dialog.ConvoTest do
  use ExUnit.Case, async: true

  import Mox

  alias Dialog.Convo
  alias Dialog.TestUtils.{SimpleMessage, StubGateway}

  setup :verify_on_exit!

  test "can receive messages" do
    {:ok, pid} = Convo.start_link([])
    assert is_pid(pid)
    message = %{}

    Convo.put_message(pid, message, SimpleMessage, StubGateway)
    assert Process.alive?(pid)
  end

  test "retains sent message" do
    {:ok, pid} = Convo.start_link([])
    message = "test-message"

    Convo.put_message(pid, message, SimpleMessage, StubGateway)
    conversation = Convo.get_messages(pid)
    assert conversation == [message]
  end

  test "sends passwords" do
    message = "test-message"
    expect(Mock.Gateway, :send_password, fn _, _ -> %HTTPotion.Response{} end)

    cast = {:put, message, SimpleMessage, Mock.Gateway}
    {:noreply, new_state} = Convo.handle_cast(cast, [])

    assert new_state == [message]
  end
end
