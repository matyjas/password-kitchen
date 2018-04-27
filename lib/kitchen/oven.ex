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
  @symbol_5 ?{..?{
  @symbol_6 ?}..?~

  def bake do
    valid_password()
  end

  defp valid_password(password \\ "", valid? \\ false)
  
  defp valid_password(password, true) do
    password
  end
  
  defp valid_password(_invalid_password, false) do
    password = password()
    valid = Kitchen.Validator.confirm(password)
    valid_password(password, valid)
  end

  defp bake_stream do
    Stream.repeatedly(&password/0)
    |> Stream.take_while(&Kitchen.Validator.confirm(&1))
    |> Stream.map(&IO.inspect(&1))
    |> Enum.at(0)
  end

  defp password do
    1..12
    |> Enum.map(&random_char(&1))
    |> to_string
  end

  defp random_char(_) do
    random_char()
  end

  defp random_char do
    import Enum, only: [concat: 2, random: 1]

    valid_chars =
      @nums
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
      |> concat(@symbol_6)

    random(valid_chars)
  end
end
