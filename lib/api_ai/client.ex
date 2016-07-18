defmodule ApiAi.Client do
  @base_url "https://api.api.ai/v1/"

  def base_url, do: @base_url

  def preform!(method, url, body \\ "", headers \\ [], options \\ []) do
    %HTTPoison.Response{body: response_body, headers: response_headers} =
      HTTPoison.request!(method, url, body, headers, options)

    {response_body, response_headers}
  end
end
