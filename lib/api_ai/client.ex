defmodule ApiAi.Client do
  @base_url "https://api.api.ai/v1/"

  def base_url, do: @base_url

  def preform!(method, url, body \\ "", headers \\ [], options \\ []) do
    %HTTPoison.Response{body: body, headers: headers} = HTTPoison.request!(method, url, body, headers, options)
    {body, headers}
  end
end
