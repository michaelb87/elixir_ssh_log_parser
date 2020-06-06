defmodule SshParserConnectionClose do
    import NimbleParsec

    @moduledoc """
    Documentation for `SshParserConnectionClose`.
  
    """

    parser =
      ignore(string("Connection closed by "))
      |> concat(CommonParser.ip_v4())
      |> optional(ignore(string(" port ")))
      |> optional(CommonParser.port())
      |> reduce({:to_map, []})

    defp to_map([ip]) do
        %{
          ip: ip,
          port: nil
        }
      end

      defp to_map([ip, port]) do
        %{
          ip: ip,
          port: port,
        }
      end
    defparsec(:parse, parser, debug: true)
  end
  