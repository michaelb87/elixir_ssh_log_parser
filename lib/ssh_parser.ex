defmodule SshParser do
  def parse(str) do
    cond do
      {:ok, [res], _, _, _, _} = SshParserSuccess.parse(str) -> {:parser_success, res}
    end
  end
end
