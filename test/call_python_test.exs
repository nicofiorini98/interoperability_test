defmodule CallPythonTest do
  use ExUnit.Case
  doctest CallPython

  test "port" do
    assert CallPython.start_port()
  end
end
