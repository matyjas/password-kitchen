defmodule Dialog.Gateway do
  @moduledoc """
  Generic gateway behavior, abstracts platform specifics
  """

  @typedoc """
  really should not expose HTTPotion over here, leaky abstraction, 
  what if we change HTTP libraries? 
  """
  @type response :: HTTPotion.Response.t()

  alias Kitchen.Password

  @callback send_message(String.t(), String.t()) :: response
  @callback send_password(String.t(), %Password{}) :: response
  @callback send_onboarding(String.t(), String.t()) :: response
end
