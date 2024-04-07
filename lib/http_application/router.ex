defmodule Router do
  require Logger

  use Plug.Router
  # plug(Plug.Logger)
  # responsible for matching routes
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, "pong")
  end

  # Handle incoming events, if the payload is the right shape, process the
  # events, otherwise return an error.
  # post "/events" do
  #   {status, body} =
  #     case conn.body_params do
  #       %{"events" => events} -> {200, process_events(events)}
  #       _ -> {422, missing_events()}
  #     end
  #   send_resp(conn, status, body)
  # end

  # post "/echo" do
  #   {status, body} =
  #     case conn.body_params do
  #       echo ->
  #         Logger.info(echo)
  #         {200,Poison.encode!(echo)}
  #     end

  #   send_resp(conn, status, body)
  # end

  # defp process_events(events) when is_list(events) do
  #   # Do some processing on a list of events
  #   Poison.encode!(%{response: "Received Events!"})
  # end

  # defp process_events(_) do
  #   # If we can't process anything, let them know :)
  #   Poison.encode!(%{response: "Please Send Some Events!"})
  # end

  # defp missing_events do
  #   Poison.encode!(%{error: "Expected Payload: { 'events': [...] }"})
  # end

  # A catchall route, 'match' will match no matter the request method,
  # so a response is always returned, even if there is no route to match.
  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end
