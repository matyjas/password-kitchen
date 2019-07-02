defmodule Support.Dialog.FakeGateway do
  @behaviour Dialog.Gateway

  @moduledoc """
  A gateway that simply writes to console
  """

  def start_link(_), do: {:ok, self()}
  def send_message(_, _, _), do: %HTTPotion.Response{}

  def send_password(_, _, password) do
    IO.puts(password)
    %HTTPotion.Response{}
  end

  def send_onboarding(_, _, _, _), do: %HTTPotion.Response{}
end
