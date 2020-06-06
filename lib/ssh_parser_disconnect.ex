defmodule SshParserDisconnect do
    import NimbleParsec

    @space 0x0020
  
    @moduledoc """
    Documentation for `SshParserDisconnect`.
  
    """
  
    port = ignore(string(" port ")) |> concat(CommonParser.port())
    disconnect_code = integer(min: 1, max: 2)

    parser =
      ignore(string("Received disconnect from "))
      |> concat(CommonParser.ip_v4())
      |> optional(port)
      |> ignore(utf8_char([?:]))
      |> optional(ignore(utf8_char([@space])))
      |> concat(disconnect_code)
      |> reduce({:to_map, []})
    
    defp to_map([ip, port, disconnect_code]) do
      %{
        ip: ip,
        port: port,
        diconnect_code: disconnect_code
      }
    end

    defp to_map([ip, disconnect_code]) do
        %{
          ip: ip,
          port: nil,
          diconnect_code: disconnect_code
        }
      end

    defparsec(:parse, parser, debug: true)
  end
  