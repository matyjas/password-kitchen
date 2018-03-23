defmodule Kitchen.OvenTest do
  use ExUnit.Case, async: true

  alias Kitchen.Oven

  describe "Oven.bake defaults produce passwords" do

    test "of 16 char" do
      password = Oven.bake
      assert is_binary(password)
      assert 16 == String.length(password)
    end

    test "containing numbers" do
      password = Oven.bake
      number_regex = ~r(\d)
      assert password =~ number_regex
    end

    test "containing non-numbers" do
      password = Oven.bake
      non_number_regex = ~r(\D)
      assert password =~ non_number_regex
    end

    test "excluding ambiguous chars" do
      password = Oven.bake
      ambig_regex = ~r([0O1l|`'])
      assert !(password =~ ambig_regex)
    end

    test "including CAPITAL letters" do
      password = Oven.bake
      capital_regex = ~r([A-Z])
      assert password =~ capital_regex
    end

    test "including lower case letters" do
      password = Oven.bake
      lower_case_regex = ~r([a-z])
      assert password =~ lower_case_regex
    end

    test "excluding whitespace" do
      password = Oven.bake
      whitespace_regex = ~r(\s)
      assert !(password =~ whitespace_regex)
    end

    test "including symbol characters" do
      password = Oven.bake
      symbol_regex = ~r([{-~/[-_:-@!-/])
      assert password =~ symbol_regex
    end
  end
end
