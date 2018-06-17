defmodule Dialog.ConvoTest do
  use ExUnit.Case, async: true

  alias Dialog.Convo
  alias Dialog.TestUtils.{SimpleMessage, MockGateway}
  
  test "can receive messages" do
    {:ok, pid} = Convo.start_link([])
    assert is_pid(pid)
    message = %{}
    parser = SimpleMessage
    gateway = MockGateway
    Convo.put_message(pid, message, parser, gateway)
    assert Process.alive?(pid)
  end

  test "retains sent message" do
    {:ok, pid} = Convo.start_link([])
    message = "test-message"
    parser = SimpleMessage
    gateway = MockGateway
    
    Convo.put_message(pid, message, parser, gateway)
    conversation = Convo.get_messages(pid)
    assert conversation == [message]
  end
end
