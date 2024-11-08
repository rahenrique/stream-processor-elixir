defmodule LogStreamTest do
  use ExUnit.Case
  doctest LogStream

  test "greets the world" do
    assert LogStream.hello() == :world
  end
end
