defmodule Telegram.TokenTest do
  use ExUnit.Case, async: true

  alias Telegram.{Token}

  test "token exists" do
    assert Token.value != nil
  end

end
