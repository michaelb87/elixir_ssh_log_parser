defmodule NoMatchTest do
    use ExUnit.Case
  
    test "no parser matched" do
      msg = "This wont match"
  
      assert SshParser.parse(msg) ==
               {:error, "No parser mached."}
    end
  

  end
  