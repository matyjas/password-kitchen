defmodule Kitchen.OvenTest do
  use ExUnit.Case

  alias Kitchen.Oven

  describe "Oven.bake defaults" do
    test "produce 16 char passwords" do
      password = Oven.bake
      assert is_binary(password)
      assert 16 == String.length(password)
    end
  end
end
