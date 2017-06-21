defmodule ApiAi.Client do
  @base_url "https://api.api.ai/v1/"

  def base_url, do: @base_url

  def preform(method, url, body \\ "", headers \\ [], options \\ []) do
      HTTPoison.request(method, url, body, headers, options)
  end
end
