defmodule SshParserUserFail do
    import NimbleParsec

    @space 0x0020
  
    @moduledoc """
    Documentation for `SshParserUserFail`.
  
    """

    # 'Failed %{NOTSPACE:auth_method} for invalid user %{USERNAME:sshd_invalid_user} from %{IP:sshd_client_ip} port %{NUMBER:sshd_port} %{WORD:sshd_protocol}'

  
    parser =
      ignore(string("Failed "))
      |> concat(CommonParser.auth_type())
      |> ignore(string(" for invalid user "))
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
  