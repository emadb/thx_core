defmodule ThxCoreTest do
  use ExUnit.Case
  doctest ThxCore

  test "greets the world" do
    assert ThxCore.hello() == :world
  end
end
