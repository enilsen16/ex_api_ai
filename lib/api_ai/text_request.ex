defmodule ApiAi.TextRequest do
  alias ApiAi.Client

  def text_request(text, options \\ %{}) when is_binary(text), do: Client.new() |> text_request(text, options)
  def text_request(%Client{} = client, text) when is_binary(text), do: text_request(client, text, %{})
  def text_request(%Client{} = client, text, %{} = options) do
    body =
      %{"query" => text, "lang" => "en"}
      |> merge_with_body(options)
      |> Poison.encode!

    Client.perform(client, :post, "/query", body, [])
  end

  defp merge_with_body(body, map) do
    Map.merge body, map
  end
end
