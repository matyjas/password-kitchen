defmodule Telegram.Gateway do
  use GenServer

  @moduledoc """
  GenServer acts as `Gateway` to Telegram messaging
  """
  
  alias Kitchen.Password
  alias HTTPotion.Response
  
  @stateless {}
  
  ## client side

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end
  
  def send_message(pid, to_id, text) do
    GenServer.cast(pid, {:send_message, to_id, text})
  end

  def send_password(pid, to_id, %Password{} = password) do
    GenServer.cast(pid, {:send_password, to_id, password})
  end

  def send_onboarding(pid, to_id, text, %Password{} = password) do
    GenServer.cast(pid, {:send_onboarding, to_id, text, password})
  end
  
  ## server side callbacks

  def init(:ok) do
    {:ok, @stateless}
  end

  def handle_cast({:send_message, to_id, message}, _stateless) do
    send_message to_id, message
    {:stop, :normal, @stateless}
  end

  def handle_cast({:send_password, to_id,
		   %Password{} = password}, _stateless) do
    send_password to_id, password
    {:stop, :normal, @stateless}
  end

  def handle_cast({:send_onboarding, to_id, text,
		   %Password{} = password},_stateless) do
    %Response{body: body} = send_message to_id, text
    # want to pull message_id out and set it as reply_to_message_id
    inspect body
    send_password to_id, password
    {:stop, :normal, @stateless}
  end

  ## private

  defp send_message(to_id, message) do
    body = Poison.encode!(%{"chat_id": to_id, "text": message})
    request("/sendMessage", body)
  end

  defp send_password(to_id, %Password{password: password}) do
    body = Poison.encode!(%{"chat_id": to_id, "text": password})
    request("/sendMessage", body)
  end
  
  defp prepare_url(suffix), do: "https://api.telegram.org/bot" <> Telegram.Token.value <> suffix

  defp request(suffix, body) do
    response = HTTPotion.post prepare_url(suffix),
      [body: body, headers: ["Content-Type": "application/json"], follow_redirects: true]
    cond do
      !Response.success?(response) ->
        inspect response
      response.status_code != 200 ->
        inspect response
      true ->
        inspect response.body
    end
    response
  end
end
