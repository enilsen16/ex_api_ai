defmodule ApiAi.Entity do
  defstruct [:eid]
  alias ApiAi.{Client}

  def get(%__MODULE__{} = entity), do: Client.new() |> get(entity)
  def get(eid) when is_binary(eid), do: Client.new() |> get(eid)
  def get(%Client{} = client, %__MODULE__{eid: eid} = entity), do: get(client, eid)
  def get(%Client{} = client, eid) when is_binary(eid) do
    path = "/entities/#{eid}"
    Client.perform(client, :get, path)
  end

  def create_entries(%__MODULE__{} = entity, entries), do: Client.new() |> create_entries(entity, entries)
  def create_entries(%Client{} = client, %__MODULE__{eid: eid}, entries) when is_list(entries) do
    path = "/entities/#{eid}/entries"

    # Should be a list of %{"value" => "foo", "synonyms" => ["bar", "baz"]} maps
    body = entries |> Poison.encode!

    Client.perform(client, :post, path, body, [])
  end


  def update_entries(%__MODULE__{} = entity, entries), do: Client.new() |> update_entries(entity, entries)
  def update_entries(%Client{} = client, %__MODULE__{eid: eid}, entries) when is_list(entries) do
    path = "/entities/#{eid}/entries"

    # Should be a list of %{"value" => "foo", "synonyms" => ["bar", "baz"]} maps
    body = entries |> Poison.encode!

    Client.perform(client, :put, path, body, [])
  end

  def delete_entries(%__MODULE__{} = entity, entries), do: Client.new() |> delete_entries(entity, entries)
  def delete_entries(%Client{} = client, %__MODULE__{eid: eid}, entries) when is_list(entries) do
    path = "/entities/#{eid}/entries"

    # Should be a list of ["value1", "value2", "value3", ...]
    body = entries |> Poison.encode!

    Client.perform(client, :delete, path, body, [])
  end
end
