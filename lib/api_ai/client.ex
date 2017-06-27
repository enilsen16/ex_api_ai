defmodule ApiAi.Client do
  defstruct [:client_access_token, :version, :base_url]
  @enforce_keys [:client_access_token, :version, :base_url]

  @base_url "https://api.api.ai/v1"
  @version "20160707"

  def new(%{} = params \\ %{}) do
    token = Application.get_env(:ex_api_ai, :client_access_token)

    %__MODULE__{
      client_access_token: token,
      version: @version,
      base_url: @base_url
    } |> Map.merge(params)
  end

  def perform(%__MODULE__{} = client, method, path, body \\ "", headers \\ [], options \\ []) do
    query_string = %{
      v: client.version
    }

    uri = URI.parse(client.base_url)
    |> Map.update!(:path, &(&1 <> path))
    |> Map.put(:query, URI.encode_query(query_string))
    |> URI.to_string

    headers = [
      {"Authorization", "Bearer #{client.client_access_token}"},
      {"Content-Type", "application/json; charset=utf-8"}
    ] ++ headers

    HTTPoison.request(method, uri, body, headers, options)
  end
end
