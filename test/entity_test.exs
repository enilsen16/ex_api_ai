defmodule EntityTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ApiAi

  alias ApiAi.{Client, Entity}

  setup_all do
    HTTPoison.start
  end

  test "should update the entries on an entity" do
    ExVCR.Config.filter_request_headers("Authorization")
    use_cassette "update_entity_entries" do
      client = Client.new(%{developer_access_token: "foo"})
      entity = %Entity{eid: "e205429c-8010-40eb-a6d4-1644a9b805cd"}

      entries = [
        %{
          "value" => "automobile",
          "synonyms" => [
            "car",
            "motorcycle"
          ]
        },
        %{
          "value" => "gas",
          "synonyms" => [
            "oxygen",
            "nitrogen"
          ]
        }
      ]

      {:ok, response} = Entity.update_entries(client, entity, entries)

      assert response["status"]["code"] == 200
    end
  end
end
