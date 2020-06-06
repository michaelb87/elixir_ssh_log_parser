defmodule SshParserSessionCloseTest do
    use ExUnit.Case
    doctest SshParserSessionClose
  
    test "pam unix session close" do
      msg = "pam_unix(sshd:session): session closed for user ubuntu"
  
      assert SshParser.parse(msg) ==
               {:session_close,
                %{
                  username: "ubuntu"
                }}
    end
  end
  