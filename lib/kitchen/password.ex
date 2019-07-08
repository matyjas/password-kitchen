defmodule Kitchen.Password do
  @moduledoc """
  container for passwords
  """

  @derive {Inspect, except: [:password]}
  @enforce_keys [:password, :size, :nums?, :caps?, :symbols?, :lowers?]
  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  defstruct password: "", size: 0, nums?: false, caps?: false, symbols?: false, lowers?: false
end

defimpl String.Chars, for: Kitchen.Password do
  def to_string(password) do
    "#{String.replace(password.password, ~r/./, "*")} has length of #{password.size}."
  end
end
