defmodule MsgPlatform.Telegram.Gateway do
  use GenServer

  @behaviour Dialog.Gateway

  @moduledoc """
  Implements `Dialog.Gateway` behaviour for Telegram messaging platform.

  Sends HTTP requests to [Telegram API](https://core.telegram.org/bots/api#sendmessage)

  This is a stateless `GenServer`, probably should be implemented as a `Task` 
  """

  alias HTTPotion.Response
  alias Kitchen.Password
  alias MsgPlatform.Telegram.Token

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
    send_message(to_id, message)
    {:stop, :normal, @stateless}
  end

  def handle_cast(
        {:send_password, to_id, %Password{} = password},
        _stateless
      ) do
    send_password(to_id, password)
    {:stop, :normal, @stateless}
  end

  def handle_cast(
        {:send_onboarding, to_id, text, %Password{} = password},
        _stateless
      ) do
    %Response{body: _body} = send_message(to_id, text)
    # want to pull message_id out and set it as reply_to_message_id
    send_password(to_id, password)
    {:stop, :normal, @stateless}
  end

  ## utils

  @doc ~S"""
  Prepares JSON for message to Telegram

  Format is based on Telegram API

  ## Example
      iex> MsgPlatform.Telegram.Gateway.encode_message(14, "Undrafted")
      "{\"chat_id\":14,\"text\":\"Undrafted\"}" 
  """
  def encode_message(to_id, message) do
    Jason.encode!(%{chat_id: to_id, text: message})
  end

  ## private

  defp send_message(to_id, message) do
    body = encode_message(to_id, message)
    request("/sendMessage", body)
  end

  defp send_password(to_id, %Password{password: password}) do
    body = encode_message(to_id, password)
    request("/sendMessage", body)
  end

  defp prepare_url(suffix) do
    "https://api.telegram.org/bot" <> Token.value() <> suffix
  end

  defp request(suffix, body) do
    response =
      HTTPotion.post(
        prepare_url(suffix),
        body: body,
        headers: ["Content-Type": "application/json"],
        follow_redirects: true
      )

    cond do
      !Response.success?(response) ->
        IO.puts(response.body)

      response.status_code != 200 ->
        IO.puts(response.body)

      true ->
        IO.puts(response.status_code)
    end

    response
  end
end
