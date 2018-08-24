defmodule Dialog.OboardingTest do
  use ExUnit.Case, async: true

  alias Dialog.Onboarding

  test "can pull onboarding" do
    greeting = Onboarding.get(0)
    assert nil != greeting
  end
end
