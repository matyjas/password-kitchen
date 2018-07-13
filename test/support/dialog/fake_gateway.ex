defmodule Support.Dialog.FakeGateway do
  @behaviour Dialog.Gateway

  @moduledoc """
  A gateway that simply writes to console
  """
  
  def send_message(_, _), do: %HTTPotion.Response{}
  
  def send_password(_, password) do
    IO.puts(password)
    %HTTPotion.Response{}
  end

  def send_onboarding(_, _), do: %HTTPotion.Response{}
end
