defmodule Codex.ItemImporter do
  alias Codex.{Items, Metadata}

  import Meeseeks.XPath

  def import() do
    file = Path.join([:code.priv_dir(:codex), "resources", "Xml", "itemnames.xml"])
    item_names = file |> File.read!() |> Meeseeks.parse(:xml)

    Metadata.Items.store()

    item_names
    |> Meeseeks.all(xpath("//key"))
    |> Enum.map(fn item ->
      item_id = item |> Meeseeks.attr("id")
      category_id = item |> Meeseeks.attr("class") |> Items.get_category_id()

      create_item(%{
        category_id: category_id,
        item_id: String.to_integer(item_id),
        name: Meeseeks.attr(item, "name"),
        slot_icon: get_slot_icon(item_id)
      })
    end)
  end

  defp get_slot_icon(item_id) do
    if prop = get_item_prop(item_id) do
      image_path =
        cond do
          Meeseeks.attr(prop, "slotIcon") != "icon0.png" ->
            Meeseeks.attr(prop, "slotIcon")

          Meeseeks.attr(prop, "slotIconCustom") != "icon0.png" ->
            Meeseeks.attr(prop, "slotIconCustom")

          true ->
            ""
        end

      case String.split(image_path, "./Data/Resource/Image") do
        [_prefix, path] -> path
        _ -> nil
      end
    end
  end

  defp get_item_prop(<<x::bytes-size(1), y::bytes-size(2), _::bytes>> = item_id) do
    path = Path.join([:code.priv_dir(:codex), "resources", "Xml", "item", x, y, "#{item_id}.xml"])

    if File.exists?(path) do
      doc = path |> File.read!() |> Meeseeks.parse(:xml)
      Meeseeks.one(doc, xpath("//property"))
    end
  end

  defp get_item_prop(_item_id), do: nil

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
      :is_two_handed,
      :is_dress
    ])
    |> Map.merge(item)
    |> Map.put(:jobs, Enum.map(metadata.jobs, &to_string/1))
  end
end
