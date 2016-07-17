defmodule TextRequestTest do
  alias ApiAi.TextRequest, as: TextRequest
  use ExUnit.Case
  doctest ApiAi

  test "should return a response" do
    response = TextRequest.text_request("Hello", %{"resetContexts" => true})
    assert response["result"]["resolvedQuery"] == "Hello"
    assert response["result"]["action"] == "greeting"
  end

  test "should use input contexts" do
    response = TextRequest.text_request("Hello", %{"resetContexts" => true})
    assert response["result"]["action"] == "greeting"

    response = TextRequest.text_request("Hello", %{"contexts" => ["firstContext"], "resetContexts" => true})
    assert response["result"]["action"] == "firstGreeting"

    response = TextRequest.text_request("Hello", %{"contexts" => ["secondContext"], "resetContexts" => true})
    assert response["result"]["action"] == "secondGreeting"
  end

  test "should return output contexts" do
    response = TextRequest.text_request "weather", %{"resetContexts" => true}
    assert response["result"]["action"] == "showWeather"
    assert response["result"]["contexts"] != nil
    assert Enum.any? response["result"]["contexts"], &(&1["name"] == "weather")
  end
end
