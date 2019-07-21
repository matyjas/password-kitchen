defmodule Dialog.Gateway do
  @moduledoc """
  Behaviour for communicating with 3rd party messaging platforms.

  Implementations of these functions correspond to specific messaging platforms.
  """

  @typedoc """
  the full HTTP response

  really should not expose `t:HTTPotion.Response.t/0` over here, leaky abstraction, 
  what if we change HTTP libraries? 
  """
  @type response :: HTTPotion.Response.t()

  alias Kitchen.Password

  @callback start_link(GenServer.option()) :: GenServer.on_start()

  @doc """
  send a plain text message to an end user.

  * `pid` is the process id
  * `to_id` is the id of the end user to whom we send the message
  * `text` is the body of the message
  """
  @callback send_message(pid, String.t(), String.t()) :: response

  @doc """
  send a password to an end user.

  * `pid` is the process id
  * `to_id` is the id of the end user to whom we send the message
  * `password` is the `Kitchen.Password` struct containing a password
  """
  @callback send_password(pid, String.t(), %Password{}) :: response

  @doc """
  send an onboarding message to an end user.

  onboarding messages will contain a password so we give value to users ASAP.
  * `pid` is the process id
  * `to_id` is the id of the end user to whom we send the message
  * `text` is the onboarding text
  * `password` is the `Kitchen.Password` struct containing a password
  """
  @callback send_onboarding(pid, String.t(), String.t(), %Password{}) :: response
end
