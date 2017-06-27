defmodule ApiAi.TextRequest do
  alias ApiAi.Client

  @version Application.get_env(:ex_api_ai, :default_version, "20160707" )
  @token Application.get_env(:ex_api_ai, :client_key)

  def text_request(text, options \\ %{}) do
    url = Client.base_url <> "query?v=" <> @version
    body =
      %{"query" => text, "lang" => "en"}
      |> merge_with_body(options)
      |> Poison.encode!

    headers = [{"Authorization", "Bearer#{@token}"}, {"Content-Type", "application/json; charset=utf-8"}]

    case Client.perform(:post, url, body, headers) do
      {:ok, %HTTPoison.Response{} = response} ->
        response.body |> Poison.Parser.parse!
      {:error, response} ->
        response
    end
  end

  defp merge_with_body(body, map) do
    Map.merge body, map
  end
end
