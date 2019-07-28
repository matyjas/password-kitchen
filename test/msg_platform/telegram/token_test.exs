defmodule MsgPlatform.Telegram.TokenTest do
  use ExUnit.Case, async: true
  doctest MsgPlatform.Telegram.Token
  alias MsgPlatform.Telegram.{Token}

  test "token exists" do
    assert Token.value() != nil
  end
end
