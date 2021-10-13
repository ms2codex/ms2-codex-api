defmodule Codex.ItemCategory do
  import Meeseeks.XPath

  def load() do
    priv = :code.priv_dir(:codex)
    file = Path.join([priv, "resources", "itemnames.xml"])

    file
    |> File.read!()
    |> Meeseeks.parse()
    |> Meeseeks.all(xpath("//key[@class]"))
    |> Enum.map(&extract_class/1)
    |> Enum.uniq()
    |> Enum.with_index()
    |> Enum.map(fn {cat, idx} -> {cat, idx} end)
  end

  defp extract_class(item) do
    item
    |> Meeseeks.attr("class")
    |> String.to_atom()
  end
end
