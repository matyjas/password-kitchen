defmodule Support.Dialog.StubGateway do
  @behaviour Dialog.Gateway

  @moduledoc """
  Implements Gateway with simple empty responses. Used in tests
  """

  def start_link(_), do: {:ok, self()}
  def send_message(_, _, _), do: %HTTPotion.Response{}
  def send_password(_, _, _), do: %HTTPotion.Response{}
  def send_onboarding(_, _, _, _), do: %HTTPotion.Response{}
end
