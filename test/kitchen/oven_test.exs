defmodule Kitchen.OvenTest do
  use ExUnit.Case, async: true

  alias Kitchen.Oven

  describe "Oven.bake defaults" do
    
    test "produce 16 char passwords" do
      password = Oven.bake
      assert is_binary(password)
      assert 16 == String.length(password)
    end

    test "produce passwords containing numbers" do
      password = Oven.bake
      number_regex = ~r(\d)
      assert password =~ number_regex
    end

    test "produce passwords excluding ambiguous chars" do
      password = Oven.bake
      ambig_regex = ~r([0O1l])
      assert !(password =~ ambig_regex)
    end
  end
end
