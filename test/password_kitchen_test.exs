defmodule PKTest do
  use ExUnit.Case
  doctest PK

  test "greets the world" do
    assert PK.hello() == :world
  end
end
