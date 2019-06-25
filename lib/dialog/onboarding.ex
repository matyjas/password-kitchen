defmodule Dialog.Onboarding do
  @moduledoc """
  Supports onboarding text
  """
  @greetings {"Welcome to Password Kitchen, we offer delicious passwords @ reasonable rates.",
              "Password Kitchen is an authentic, family run restaurant specialising in high quality passwords for modern customers",
              "Open 24 hours a day for take-away passwords of the highest quality",
  "Free refills on standard size passwords"}

  def get(timestamp), do: @greetings |> elem(rem(timestamp, 4))
end
