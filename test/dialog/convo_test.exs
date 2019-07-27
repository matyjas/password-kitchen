defmodule Dialog.ConvoTest do
  use ExUnit.Case, async: true

  import Mox

  alias Dialog.Convo

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

    call = {:put_msg, start_message, "summer-sender", Mock.Gateway}
    empty_state = []
    {:reply, :ok, new_state} = Convo.handle_call(call, self(), empty_state)

    assert new_state == [start_message]
  end

  test "sends passwords" do
    message = "test-message"
    mock_action = fn _, _, _ -> %HTTPotion.Response{} end
    expect(Mock.Gateway, :start_link, fn _ -> {:ok, self()} end)
    expect(Mock.Gateway, :send_password, mock_action)

    call = {:put_msg, message, "stacy-sender", Mock.Gateway}
    state = [message]
    {:reply, :ok, conversation} = Convo.handle_call(call, self(), state)

    assert conversation == [message, message]
  end
end
