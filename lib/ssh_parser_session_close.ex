defmodule SshParserSessionClose do
    import NimbleParsec

    @moduledoc """
    Documentation for `SshParserSessionClose`.
  
    """

    parser =
      ignore(string("pam_unix(sshd:session): session closed for user "))
      |> concat(CommonParser.username())
      |> reduce({:to_map, []})

    defp to_map([username]) do
        %{
          username: username,
        }
      end

    defparsec(:parse, parser, debug: true)
  end
  