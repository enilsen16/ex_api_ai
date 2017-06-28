defmodule TextRequestTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ApiAi

  setup_all do
    HTTPoison.start
  end

  test "should return a response" do
    use_cassette "api_ai_response" do
      {:ok, response} = ApiAi.text_request("Hello", %{"resetContexts" => true})
      assert response["result"]["resolvedQuery"] == "Hello"
      assert response["result"]["action"] == "greeting"
    end
  end

  test "should use input contexts" do
    use_cassette "context" do
      {:ok, response} = ApiAi.text_request("Hello", %{"resetContexts" => true})
      assert response["result"]["action"] == "greeting"
    end

    use_cassette "context-1" do
      {:ok, response} = ApiAi.text_request("Hello", %{"contexts" => ["firstContext"], "resetContexts" => true})
      assert response["result"]["action"] == "firstGreeting"
    end

    use_cassette "context-2" do
      {:ok, response} = ApiAi.text_request("Hello", %{"contexts" => ["secondContext"], "resetContexts" => true})
      assert response["result"]["action"] == "secondGreeting"
    end
  end

  test "should return output contexts" do
    use_cassette "output context" do
      {:ok, response} = ApiAi.text_request "weather", %{"resetContexts" => true}
      assert response["result"]["action"] == "showWeather"
      assert response["result"]["contexts"] != nil
      assert Enum.any? response["result"]["contexts"], &(&1["name"] == "weather")
    end
  end
end
