defmodule Codex.ItemImporter do
  alias Codex.{Items, Metadata}

  import Meeseeks.XPath

  def import() do
    priv = :code.priv_dir(:codex)
    file = Path.join([priv, "resources", "itemnames.xml"])
    item_names = file |> File.read!() |> Meeseeks.parse()

    Metadata.Items.store()

    item_names
    |> Meeseeks.all(xpath("//key"))
    |> Enum.map(fn item ->
      item_id = item |> Meeseeks.attr("id") |> String.to_integer()
      category_id = item |> Meeseeks.attr("class") |> Items.get_category_id()

      create_item(%{
        category_id: category_id,
        item_id: item_id,
        name: Meeseeks.attr(item, "name")
      })
    end)
  end

  defp create_item(item) do
    with {:ok, metadata} <- Metadata.Items.lookup(item.item_id),
         item <- put_metadata(item, metadata) do
      Items.create(item)
    end
  end

  defp put_metadata(item, metadata) do
    metadata
    |> Map.take([
      :slot,
      :gem_slot,
      :tab,
      :rarity,
      :is_two_handed,
      :is_dress
    ])
    |> Map.merge(item)
    |> Map.put(:jobs, Enum.map(metadata.jobs, &to_string/1))
  end
end
