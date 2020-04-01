defmodule ElixirWebsocketAppTest do
  use ExUnit.Case
  doctest ElixirWebsocketApp

  test "greets the world" do
    assert ElixirWebsocketApp.hello() == :world
  end
end
