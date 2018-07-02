defmodule Dialog.TestUtils.StubGateway do
  @behaviour Dialog.Gateway

  def send_message(_, _), do: %HTTPotion.Response{}
  def send_password(_, _), do: %HTTPotion.Response{}
  def send_onboarding(_, _), do: %HTTPotion.Response{}
end
