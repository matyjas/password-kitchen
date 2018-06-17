defmodule Dialog.ConvoTest do
  use ExUnit.Case, async: true

  alias Dialog.Convo
  
  test "can receive messages" do
    {:ok, pid} = Convo.start_link([])
    assert is_pid(pid)
    message = %{}
    parser = Dialog.SimpleMessage
    gateway = Dialog.MockGateway
    Convo.put_message(pid, message, parser, gateway)
    assert Process.alive?(pid)
  end

  test "retains sent message" do
    {:ok, pid} = Convo.start_link([])
    message = "test-message"
    parser = Dialog.SimpleMessage
    gateway = Dialog.MockGateway
    
    Convo.put_message(pid, message, parser, gateway)
    conversation = Convo.get_messages(pid)
    assert conversation == [message]
  end
end
