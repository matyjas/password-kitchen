defmodule Kitchen.ValidatorTest do
  use ExUnit.Case, async: true

  alias Kitchen.Validator

  test "decent password is valid according to rules" do
    password = "4?KG9LD`bQ?H"
    assert Validator.confirm(password)
  end
  
  test "password with no chars is invalid" do
    password = "123456789123"
    refute Validator.confirm(password)
  end

  @tag :skip
  test "password with no numbers is invalid" do
    password = "passwordword"
    refute Validator.confirm(password)
  end

  test "has_chars passes password with chars" do
    password = "7pnO3*3830!V"
    assert Validator.has_chars(password)
  end

  test "has_chars fails password without chars" do
    password = "123~!@456$%^"
    refute Validator.has_chars(password)
  end
end
