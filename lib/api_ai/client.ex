defmodule ApiAi.Client do
  defstruct [:client_access_token, :version, :base_url]
  @enforce_keys [:client_access_token, :version, :base_url]

  @base_url "https://api.api.ai/v1/"
  @version "20160707"

  def new(%{} = params \\ %{}) do
    token = Application.get_env(:ex_api_ai, :client_access_token)

    %__MODULE__{
      client_access_token: token,
      version: @version,
      base_url: @base_url
    } |> Map.merge(params)
  end

  def perform(method, url, body \\ "", headers \\ [], options \\ []) do
    HTTPoison.request(method, url, body, headers, options)
  end
end
