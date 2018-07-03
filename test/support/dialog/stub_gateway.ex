defmodule Support.Dialog.StubGateway do
  @behaviour Dialog.Gateway

  @moduledoc """
  Implements Gateway with simple empty responses. Used in tests
  """

  def send_message(_, _), do: %HTTPotion.Response{}
  def send_password(_, _), do: %HTTPotion.Response{}
  def send_onboarding(_, _), do: %HTTPotion.Response{}
end
