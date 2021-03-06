defmodule MsgPlatform.Telegram.UpdateTest do
  use ExUnit.Case, async: true

  alias MsgPlatform.Telegram.Update

  @start_mess_id 228_303_213
  @start_mess_date 1_510_610_264
  @start_mess_text "/start"
  @start_mess %{
    "message" => %{
      "chat" => %{
        "first_name" => "Maciej",
        "id" => @start_mess_id,
        "type" => "private",
        "username" => "Matyjas"
      },
      "date" => @start_mess_date,
      "entities" => [%{"length" => 6, "offset" => 0, "type" => "bot_command"}],
      "from" => %{
        "first_name" => "Maciej",
        "id" => 228_303_213,
        "is_bot" => false,
        "language_code" => "en-US",
        "username" => "Matyjas"
      },
      "message_id" => 1,
      "text" => @start_mess_text
    },
    "update_id" => 158_840_565
  }

  @samp_mess_id 228_303_213
  @samp_mess_date 1_510_610_291
  @samp_mess %{
    "message" => %{
      "chat" => %{
        "first_name" => "Maciej",
        "id" => @samp_mess_id,
        "type" => "private",
        "username" => "Matyjas"
      },
      "date" => @samp_mess_date,
      "from" => %{
        "first_name" => "Maciej",
        "id" => 228_303_213,
        "is_bot" => false,
        "language_code" => "en-US",
        "username" => "Matyjas"
      },
      "message_id" => 2,
      "text" => "Test"
    },
    "update_id" => 158_840_566
  }

  describe "Dialog.Message @behaviour" do
    test "extracts sender id" do
      {:ok, sender_id} = Update.extract_sender_id(@start_mess)
      assert @start_mess_id == sender_id
    end

    test "extracts date" do
      {:ok, date} = Update.extract_date(@start_mess)
      assert @start_mess_date == date
    end

    test "extracts utterance" do
      {:ok, text} = Update.extract_utterance(@start_mess)
      assert @start_mess_text == text
    end
  end

  test "sad path" do
    # warning logged from here
    boo = "boo"
    {unhandled_update_type, _error_message} = Update.extract_sender_id(boo)
    assert :error == unhandled_update_type
  end

  test "sample message" do
    {:ok, sender_id} = Update.extract_sender_id(@samp_mess)
    assert @samp_mess_id == sender_id
    {:ok, date} = Update.extract_date(@samp_mess)
    assert @samp_mess_date == date
  end
end
