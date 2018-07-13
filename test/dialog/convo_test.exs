defmodule Dialog.ConvoTest do
  use ExUnit.Case, async: true

  import Mox

  alias Dialog.Convo
  alias Support.Dialog.StubMessage

  @gateway Support.Dialog.StubGateway #FakeGateway
  
  setup :verify_on_exit!

  test "can receive messages" do
    {:ok, pid} = Convo.start_link([])
    assert is_pid(pid)
    message = %{}

    Convo.put_message(pid, message, StubMessage, @gateway)
    assert Process.alive?(pid)
  end

  test "retains sent message" do
    {:ok, pid} = Convo.start_link([])
    message = "test-message"

    Convo.put_message(pid, message, StubMessage, @gateway)
    conversation = Convo.get_messages(pid)
    assert conversation == [message]
  end

  test "sends passwords" do
    message = "test-message"
    expect(Mock.Gateway, :send_password, fn _, _ -> %HTTPotion.Response{} end)

    cast = {:put, message, StubMessage, Mock.Gateway}
    {:noreply, new_state} = Convo.handle_cast(cast, [])

    assert new_state == [message]
  end
end
