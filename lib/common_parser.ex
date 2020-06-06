defmodule CommonParser do
  import NimbleParsec

  @space 0x0020

  def ip_v4 do
    repeat(
      choice([
        utf8_string([?0..?9], min: 1, max: 3),
        string(".")
      ])
    )
    |> reduce({List, :to_string, []})
  end

  def username do
    utf8_string([?a..?z, ?A..?Z, ?0..?9, ?., ?-, ?_], min: 1)
  end

  def port do
    integer(min: 1)
  end

  def protocol do
    utf8_string([?a..?z, ?0..?9], min: 1)
  end

  def auth_type do
    utf8_string([{:not, @space}], min: 1)
  end
end
