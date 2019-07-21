defmodule Kitchen.Validator do
  @moduledoc """
  password rule validator
  """

  @doc "Checks password against all funcs in `Kitchen.Validator`"
  @spec confirm(Kitchen.Password.t()) :: boolean()
  def confirm(password) do
    # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
    has_char(password) && has_num(password) && has_sym(password) && has_caps(password)
  end

  @doc "Checks if password has lower case characters"
  @spec has_char(Kitchen.Password.t()) :: boolean()
  def has_char(password) do
    password =~ ~r([a-z])
  end

  @doc "Checks if password has UPPER case characters"
  @spec has_caps(Kitchen.Password.t()) :: boolean()
  def has_caps(password) do
    password =~ ~r([A-Z])
  end

  @doc "Checks if password has numb3rs"
  @spec has_num(Kitchen.Password.t()) :: boolean()
  def has_num(password) do
    password =~ ~r([0-9])
  end

  @doc "Checks if password has $ymbols"
  @spec has_sym(Kitchen.Password.t()) :: boolean()
  def has_sym(password) do
    password =~ ~r([]}~!@#%&_=:;",/\$\?\^\*\(\)\-\+\[\{\\\.\<\>\?])
  end
end
