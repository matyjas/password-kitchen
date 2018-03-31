defmodule Kitchen.Oven do
  @moduledoc """
  In the Password Kitchen, Oven bakes passwords
  """

  @nums ?2..?9
  @lower_case_1 ?a..?k
  @lower_case_2 ?m..?z
  @upper_case_1 ?A..?H
  @upper_case_2 ?J..?N
  @upper_case_3 ?P..?Z
  @symbol_1 ?!..?&
  @symbol_2 ?(..?/
  @symbol_3 ?:..?@
  @symbol_4 ?[..?_
  @symbol_5 ?{..?~

  def bake do
    password
  end

  defp password do
    1..12
    |> Enum.map(&(random_char(&1)))
    |> to_string
  end
  
  defp random_char(_) do
    random_char()
  end

  defp random_char() do
    import Enum, only: [concat: 2, random: 1]
    
    valid_chars = @nums
    |> concat(@lower_case_1)
    |> concat(@lower_case_2)
    |> concat(@upper_case_1)
    |> concat(@upper_case_2)
    |> concat(@upper_case_3)
    |> concat(@symbol_1)
    |> concat(@symbol_2)
    |> concat(@symbol_3)
    |> concat(@symbol_4)
    |> concat(@symbol_5)
    
    random(valid_chars)
  end
end
