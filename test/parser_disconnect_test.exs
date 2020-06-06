defmodule SshParserDisconnectTest do
  use ExUnit.Case
  doctest SshParserDisconnect

  test "disconnect" do
    msg = "Received disconnect from 127.0.0.1 port 55452:11: disconnected by user"

    assert SshParser.parse(msg) ==
             {:disconnect, %{ip: "127.0.0.1", port: 55452, diconnect_code: 11}}
  end

  test "disconnect without port" do
    msg = "Received disconnect from 84.113.248.94: 11: disconnected by user"

    assert SshParser.parse(msg) ==
             {:disconnect, %{diconnect_code: 11, ip: "84.113.248.94", port: nil}}
  end
end
