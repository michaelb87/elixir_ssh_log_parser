defmodule SshParser do
  def parse(str) do
    
    modules = [
      {:user_fail, SshParserUserFail},
      {:parser_success, SshParserSuccess},
    ]

    eval_modules(modules, str)
  end

  defp eval_modules([module|remaining_modules], str) do
    case apply(elem(module, 1), :parse, [str]) do
      {:ok, [result], _, _, _, _} -> {elem(module, 0), result}
      {:error, _, _, _, _, _} -> eval_modules(remaining_modules, str)
    end
  end

  defp eval_modules([], str) do
    {:error, "No parser mached."}
  end
end
