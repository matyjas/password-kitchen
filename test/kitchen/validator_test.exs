defmodule Kitchen.ValidatorTest do
  use ExUnit.Case, async: true

  import Kitchen.Validator

  describe ".confirm checks that" do
    test "decent password" do
      password = "4?KG9LD`bQ?H"
      assert confirm(password)
    end

    test "password with no chars (fails)" do
      password = "123456789123"
      refute confirm(password)
    end

    test "password with no numbers (fails)" do
      password = "passwordword"
      refute confirm(password)
    end

    test "password with no symbols (fails)" do
      password = "123Pass456word"
      refute confirm(password)
    end

    test "password with no caps (fails)" do
      password = "~1whorms"
      refute confirm(password)
    end
  end

  describe "helper funcs for rules" do
    test ".has_chars passes password with chars" do
      password = "7pnO3*3830!V"
      assert has_char(password)
    end

    test ".has_chars fails password without chars" do
      password = "123~!@456$%^"
      refute has_char(password)
    end

    test ".has_nums passes password with nums" do
      password = "tLZSQG8y"
      assert has_num(password)
    end

    test ".has_nums fails password without nums" do
      password = "passpasswordword"
      refute has_num(password)
    end

    test ".has_sym passes password with symbols" do
      password = "25464%h&HWYb"
      assert has_sym(password)
    end

    test ".has_sym fails password without symbols" do
      password = "tLZSQG8y"
      refute has_sym(password)
    end

    test ".has_caps passes password with caps" do
      password = "PASSWORD1234"
      assert has_caps(password)
    end

    test ".has_caps fails password without caps" do
      password = "*w9<\3x.v!w/vd6`"
      refute has_caps(password)
    end
  end
end
