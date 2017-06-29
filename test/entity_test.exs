defmodule EntityTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ApiAi

  alias ApiAi.{Client, Entity}

  setup_all do
    HTTPoison.start

    ExVCR.Config.filter_request_headers("Authorization")

    client = Client.new(%{developer_access_token: "foo"})
    entity = %Entity{eid: "e205429c-8010-40eb-a6d4-1644a9b805cd"}

    {:ok, client: client, entity: entity}
  end

  test "should get an entity", %{client: client, entity: entity} do
    use_cassette "get_entity" do
      {:ok, response} = Entity.get(client, entity)

      assert response["name"] == "dimension_value"
      assert response["id"] == "e205429c-8010-40eb-a6d4-1644a9b805cd"
    end
  end

  test "should create the entries on an entity", %{client: client, entity: entity} do
    use_cassette "create_entity_entries" do
      entries = [
        %{
          "value" => "tree",
          "synonyms" => [
            "maple",
            "oak"
          ]
        },
        %{
          "value" => "john",
          "synonyms" => [
            "johnny",
            "jack"
          ]
        }
      ]

      {:ok, response} = Entity.create_entries(client, entity, entries)

      assert response["status"]["code"] == 200
    end
  end

  test "should update the entries on an entity", %{client: client, entity: entity} do
    use_cassette "update_entity_entries" do
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

  test "should delete the entries on an entity", %{client: client, entity: entity} do
    use_cassette "delete_entity_entries" do
      entries = ["automobile", "gas", "notpresent"]

      {:ok, response} = Entity.delete_entries(client, entity, entries)

      assert response["status"]["code"] == 200
    end
  end
end
