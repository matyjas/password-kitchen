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

  @callback start_link(GenServer.option) :: GenServer.on_start
  @callback send_message(pid, String.t(), String.t()) :: response
  @callback send_password(pid, String.t(), %Password{}) :: response
  @callback send_onboarding(pid, String.t(), String.t(), %Password{}) :: response
end
