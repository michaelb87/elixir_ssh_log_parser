defmodule SshParserSuccess do
    import NimbleParsec
  
    @moduledoc """
    Documentation for `SshParserSuccess`.
  
    """
  
    auth_type = ascii_string([?a..?z], min: 1)
    username = ascii_string([?a..?z, ?A..?Z, ?0..?9, ?., ?-, ?_], min: 1)
  
    ip_v4 = 
      repeat(
          choice(
            [
              ascii_string([?0..?9], min: 1, max: 3), 
              string(".")]
          )
        ) 
      |> reduce({List, :to_string, []})
  
    port = integer(min: 1)
    
    protocol = ascii_string([?a..?z, ?0..?9], min: 1)
    
    algo_name = ascii_string([?a..?z, ?A..?Z, ?-], min: 1) 
  
    cipher = ascii_string([?a..?z, ?A..?Z, ?0..?9, ?:, ?/, ?+, ?\\, ?=, ?., ?,], min: 4) 
  
  
    parser =
      ignore(string("Accepted "))
      |> concat(auth_type)
      |> ignore(string(" for "))
      |> concat(username)
      |> ignore(string(" from "))
      |> concat(ip_v4)
      |> ignore(string(" port "))
      |> concat(port)
      |> ignore(string(" "))
      |> concat(protocol)
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
  