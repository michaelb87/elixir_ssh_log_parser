defmodule SshParserSuccess do
    import NimbleParsec
  
    @moduledoc """
    Documentation for `SshParserSuccess`.
  
    """
    
    algo_name = utf8_string([?a..?z, ?A..?Z, ?-], min: 1) 
  
    cipher = utf8_string([?a..?z, ?A..?Z, ?0..?9, ?:, ?/, ?+, ?\\, ?=, ?., ?,], min: 4) 
  
  
    parser =
      ignore(string("Accepted "))
      |> concat(CommonParser.auth_type())
      |> ignore(string(" for "))
      |> concat(CommonParser.username()) 
      |> ignore(string(" from "))
      |> concat(CommonParser.ip_v4())
      |> ignore(string(" port "))
      |> concat(CommonParser.port()) 
      |> ignore(string(" "))
      |> concat(CommonParser.protocol())
      |> optional(ignore(string(": ")))
      |> optional(ignore(string(" ")))
      |> optional(algo_name)
      |> optional(ignore(string(" ")))
      |> optional(cipher)
      |> reduce({:to_map, []})
    
    defp to_map(list) do
      %{
        auth_type: Enum.at(list, 0),
        username: Enum.at(list, 1),
        ip: Enum.at(list, 2),
        port: Enum.at(list, 3),
        protocol: Enum.at(list, 4),
        algorithm_name: Enum.at(list, 5),
        cipher: Enum.at(list, 6)
      }
    end
    defparsec(:parse, parser, debug: true)
  end
  