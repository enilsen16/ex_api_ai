defmodule ApiAi.Entity do
  defstruct [:eid]
  alias ApiAi.{Client}

  def update_entries(%__MODULE__{} = entity, entries), do: Client.new() |> update_entries(entity, entries)
  def update_entries(%Client{} = client, %__MODULE__{eid: eid}, entries) when is_list(entries) do
    query = "/entities/#{eid}/entries"

    # Should be a list of %{"value" => "foo", "synonyms" => ["bar", "baz"]} maps
    body = entries |> Poison.encode!

    case Client.perform(client, :put, query, body, []) do
      {:ok, %HTTPoison.Response{} = response} ->
        response.body |> Poison.Parser.parse!
      {:error, response} ->
        response
    end
  end
end
