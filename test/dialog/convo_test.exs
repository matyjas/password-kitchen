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
    parser = SimpleMessage
    gateway = StubGateway
    Convo.put_message(pid, message, parser, gateway)
    assert Process.alive?(pid)
  end

  test "retains sent message" do
    {:ok, pid} = Convo.start_link([])
    message = "test-message"
    parser = SimpleMessage
    gateway = StubGateway

    Convo.put_message(pid, message, parser, gateway)
    conversation = Convo.get_messages(pid)
    assert conversation == [message]
  end

  test "sends passwords" do
    message = "test-message"
    parser = SimpleMessage
    expect(Mock.Gateway, :send_password, fn _, _ -> %HTTPotion.Response{} end)

    {:noreply, new_state} = Convo.handle_cast({:put, message, parser, Mock.Gateway}, [])

    assert new_state == [message]
  end
end
