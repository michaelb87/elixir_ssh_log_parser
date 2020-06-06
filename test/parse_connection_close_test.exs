defmodule SshParserConnectionCloseTest do
  use ExUnit.Case
  doctest SshParserConnectionClose

  test "ssh connection close port and preauth" do
    msg = "Connection closed by 148.229.3.242 port 58747 [preauth]"

    assert SshParser.parse(msg) ==
             {:connection_close,
              %{
                ip: "148.229.3.242",
                port: 58747
              }}
  end

  test "ssh connection close preauth" do
    msg = "Connection closed by 148.229.3.242"

    assert SshParser.parse(msg) ==
             {:connection_close,
              %{
                ip: "148.229.3.242",
                port: nil
              }}
  end
end
