defmodule Kitchen.Validator do
  @moduledoc """
  password rule validator
  """

  def confirm(password) do
    has_chars(password)
  end

  def has_chars(password) do
    password =~ ~r([a-z])
  end
end
