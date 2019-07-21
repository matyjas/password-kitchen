defmodule Kitchen.Password do
  @moduledoc """
  A struct that holds a password
  """

  @derive {Inspect, except: [:password]}
  @enforce_keys [:password, :size, :nums?, :caps?, :symbols?, :lowers?]
  defstruct password: "", size: 0, nums?: false, caps?: false, symbols?: false, lowers?: false

  @typedoc """
  Holds the password and information about it.
  """
  @type t :: %__MODULE__{
          password: String.t(),
          size: pos_integer(),
          nums?: boolean(),
          caps?: boolean(),
          symbols?: boolean(),
          lowers?: boolean()
        }
end

defimpl String.Chars, for: Kitchen.Password do
  def to_string(password) do
    "#{String.replace(password.password, ~r/./, "*")} has length of #{password.size}."
  end
end
