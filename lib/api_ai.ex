defmodule ApiAi do
  alias ApiAi.{TextRequest, Client}

  @doc """
    Send Text Request query to Api.ai
  """
  def text_request(text, options \\ %{}) do
    TextRequest.text_request(text, options)
  end
end
