defmodule Dialog.ConvoTest do
  use ExUnit.Case, async: true

  import Mox

  alias Dialog.Convo
  alias Support.Dialog.StubMessage

  @gateway Support.Dialog.StubGateway
  # FakeGateway

  setup :verify_on_exit!

  test "can receive messages" do
    {:ok, pid} = Convo.start_link([])
    assert is_pid(pid)
    message = "an utterance"

    Convo.put_message(pid, message, "sweta_sendy", @gateway)
    assert Process.alive?(pid)
  end

  test "retains sent message" do
    {:ok, pid} = Convo.start_link([])
    message = "test-message"

    Convo.put_message(pid, message, "suzy-sender", @gateway)
    conversation = Convo.get_messages(pid)
    assert conversation == [message]
  end

  test "onboarding for new conversations" do
    start_message = "/start"
    mock_action = fn _, _, _, _ -> %HTTPotion.Response{} end
    expect(Mock.Gateway, :start_link, fn _ -> {:ok, self()} end)
    expect(Mock.Gateway, :send_onboarding, mock_action)

    cast = {:put, start_message, StubMessage, Mock.Gateway}
    empty_state = []
    {:noreply, new_state} = Convo.handle_cast(cast, empty_state)

    assert new_state == [start_message]
  end

  test "sends passwords" do
    message = "test-message"
    mock_action = fn _, _, _ -> %HTTPotion.Response{} end
    expect(Mock.Gateway, :start_link, fn _ -> {:ok, self()} end)
    expect(Mock.Gateway, :send_password, mock_action)

    cast = {:put, message, StubMessage, Mock.Gateway}
    state = [message]
    {:noreply, conversation} = Convo.handle_cast(cast, state)

    assert conversation == [message, message]
  end
end
