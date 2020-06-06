defmodule SshParserSuccess do
    import NimbleParsec
  
    @moduledoc """
    Documentation for `SshParserSuccess`.
  
    """
  
    # '(?<sshd_result>Accepted) %{WORD:sshd_auth_type} for %{USERNAME:sshd_user} from %{IP:sshd_client_ip} port %{NUMBER:sshd_port} %{WORD:sshd_protocol}(: )?(?:%{GREEDYDATA:sshd_cipher})' // overwrite
  
    # 'Accepted publickey for pi from 193.154.87.64 port 57032 ssh2: RSA ef:93:98:3b:f3:48:09:75:c5:57:5a:05:0f:7b:4e:4a'
    # 'Accepted password for one from 127.0.0.1 port 54564 ssh2'
  
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
  