defmodule SshParserTest do
  use ExUnit.Case
  doctest SshParser

  test "success pw auth" do
    msg = "Accepted password for one from 127.0.0.1 port 54564 ssh2"

    assert SshParser.parse(msg) ==
             {:parser_success,
              %{
                algorithm_name: nil,
                auth_type: "password",
                cipher: nil,
                ip: "127.0.0.1",
                port: 54564,
                protocol: "ssh2",
                username: "one"
              }}
  end

  test "success key" do
    msg =
      "Accepted publickey for pi from 193.154.87.64 port 57032 ssh2: RSA ef:93:98:4b:f3:48:09:75:c5:57:5a:05:0f:7b:4e:4a"

    assert SshParser.parse(msg) ==
             {:parser_success,
              %{
                algorithm_name: "RSA",
                auth_type: "publickey",
                cipher: "ef:93:98:4b:f3:48:09:75:c5:57:5a:05:0f:7b:4e:4a",
                ip: "193.154.87.64",
                port: 57032,
                protocol: "ssh2",
                username: "pi"
              }}
  end
end
