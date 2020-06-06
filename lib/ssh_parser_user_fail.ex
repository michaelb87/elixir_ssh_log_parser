defmodule SshParserUserFail do
    import NimbleParsec

    @space 0x0020
  
    @moduledoc """
    Documentation for `SshParserUserFail`.
  
    """
  
    parser =
      ignore(string("Failed "))
      |> concat(CommonParser.auth_type())
      |> ignore(string(" for "))
      |> optional(ignore(string("invalid user ")))
      |> concat(CommonParser.username()) 
      |> ignore(string(" from "))
      |> concat(CommonParser.ip_v4())
      |> ignore(string(" port "))
      |> concat(CommonParser.port()) 
      |> ignore(utf8_char([@space]))
      |> concat(CommonParser.protocol())
      |> reduce({:to_map, []})
    
    defp to_map(list) do
      %{
        auth_type: Enum.at(list, 0),
        username: Enum.at(list, 1),
        ip: Enum.at(list, 2),
        port: Enum.at(list, 3),
        protocol: Enum.at(list, 4),
      }
    end
    defparsec(:parse, parser, debug: true)
  end
  