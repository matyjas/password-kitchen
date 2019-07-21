defmodule Dialog.Onboarding do
  @moduledoc ~S"""
  Provides onboarding text snippets
  """

  @greetings {"Welcome to Password Kitchen, we offer delicious passwords @ reasonable rates.",
              "Password Kitchen is an authentic, family run restaurant specialising in high quality passwords for modern customers",
              "Open 24 hours a day for take-away passwords of the highest quality",
              "Free refills on standard size passwords"}

  @doc """
  Returns different greetings based on timestamp

  ## Examples

      iex(1)> Dialog.Onboarding.get(3)
      "Free refills on standard size passwords" 

      iex(2)> Dialog.Onboarding.get(6)
      "Open 24 hours a day for take-away passwords of the highest quality"


  """
  @spec get(integer()) :: String.t()
  def get(timestamp), do: @greetings |> elem(rem(timestamp, 4))
end
