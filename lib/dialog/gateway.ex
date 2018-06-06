defmodule Dialog.Gateway do

  @moduledoc """
  Generic gateway behavior, abstracts platform specifics
  """

  @callback send_message(String.t, String.t) :: HTTPotion.Response.t
  @callback send_password(String.t, String.t) :: HTTPotion.Response.t
  @callback send_onboarding(String.t, String.t) :: HTTPotion.Response.t
end
