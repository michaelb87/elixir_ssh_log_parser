defmodule SshParser do
  def parse(str) do
    
    modules = [
      {:session_close, SshParserSessionClose},
      {:connection_close, SshParserConnectionClose},
      {:user_fail, SshParserUserFail},
      {:success, SshParserSuccess},
      {:disconnect, SshParserDisconnect},
    ]

    eval_modules(modules, str)
  end

  defp eval_modules([{module_type, module} | remaining_modules], str) do
    case apply(module, :parse, [str]) do
      {:ok, [result], _, _, _, _} -> {module_type, result}
      {:error, _, _, _, _, _} -> eval_modules(remaining_modules, str)
    end
  end

  defp eval_modules([], str) do
    {:error, "No parser mached."}
  end
end
