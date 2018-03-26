defmodule Kitchen.Oven do
  @moduledoc """
  In the Password Kitchen, Oven bakes passwords
  """

  @nums ?2..?9

  
  def bake do
    @nums
    |> Enum.take_random(12)
    |> to_string
  end
end
