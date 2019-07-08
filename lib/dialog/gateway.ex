defmodule Dialog.Gateway do
  @moduledoc """
  Behaviour for communicating with 3rd party messaging platforms.

  Implementations of these functions correspond to specific messaging platforms.
  """

  @typedoc """
  really should not expose HTTPotion over here, leaky abstraction, 
  what if we change HTTP libraries? 
  """
  @type response :: HTTPotion.Response.t()

  alias Kitchen.Password

  @callback start_link(GenServer.option()) :: GenServer.on_start()

  @doc """
  send a plain text message to the end user.

  `pid` is the process id
  `to_id` is the id of the end user to whom we send the message
  `text` is the body of the message
  """
  @callback send_message(pid, String.t(), String.t()) :: response
  @callback send_password(pid, String.t(), %Password{}) :: response
  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  @callback send_onboarding(pid, String.t(), String.t(), %Password{}) :: response
end
