defmodule Kitchen.Validator do
  @moduledoc """
  password rule validator
  """

  def confirm(password) do
    has_char(password) &&
      has_num(password) &&
      has_sym(password) &&
      has_caps(password)
  end

  def has_char(password) do
    password =~ ~r([a-z])
  end

  def has_caps(password) do
    password =~ ~r([A-Z])
  end

  def has_num(password) do
    password =~ ~r([0-9])
  end

  def has_sym(password) do
    password =~ ~r([]}~!@#%&_=:;",/\$\?\^\*\(\)\-\+\[\{\\\.\<\>\?])
  end
end
