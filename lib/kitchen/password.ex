defmodule Kitchen.Password do
  @moduledoc """
  container for passwords
  """

  alias __MODULE__

  defstruct password: "", length: 0,
    nums?: false, caps?: false, symbols?: false, lowers?: false
  
end
