defmodule SshParserUserFailTest do
  use ExUnit.Case
  doctest SshParserUserFail

  test "invalid user" do
    msg = "Failed password for invalid user admin from 23.233.109.49 port 39253 ssh2"

    assert SshParser.parse(msg) ==
             {:user_fail,
              %{
                auth_type: "password",
                ip: "23.233.109.49",
                port: 39253,
                protocol: "ssh2",
                username: "admin"
              }}
  end

  test "invalid user bsd" do
    msg =
      "Failed keyboard-interactive/pam for invalid user roots from 84.113.248.94 port 59460 ssh2"

    assert SshParser.parse(msg) ==
             {
               :user_fail,
               %{
                 auth_type: "keyboard-interactive/pam",
                 ip: "84.113.248.94",
                 port: 59460,
                 protocol: "ssh2",
                 username: "roots"
               }
             }
  end
end
