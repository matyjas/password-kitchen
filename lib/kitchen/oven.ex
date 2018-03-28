defmodule Kitchen.Oven do
  @moduledoc """
  In the Password Kitchen, Oven bakes passwords
  """

  @nums ?2..?9

  
  def bake do

    1..12
    |> Enum.map(&(random_char(&1)))
    |> to_string

  end

  defp random_char(_) do
    random_char()
  end

  defp random_char() do
    Enum.random(@nums)
  end
end
