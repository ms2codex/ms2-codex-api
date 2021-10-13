defmodule Codex.ItemFilter do
  import Ecto.Query

  @filters [
    {"item_id", :match},
    {"name", :like},
    {"category_id", :match},
    {"category_ids", :inclusion},
    {"equip_slot", :match},
    {"gem_slot", :match},
    {"inventory_tab", :match},
    {"rarity", :match},
    {"is_two_handed", :match},
    {"is_dress", :match},
    {"jobs", :inclusion}
  ]

  def filter(query, [{field, val} | filters]) do
    val = String.trim(val)
    filter = Enum.find(@filters, fn {name, _type} -> name == field end)

    query
    |> apply_filter(filter, val)
    |> filter(filters)
  end

  def filter(query, _), do: query

  defp apply_filter(query, filter, value) when is_nil(filter) or value == "", do: query

  defp apply_filter(query, {"category_ids", :inclusion}, value) do
    ids = String.split(value, ",")
    where(query, [i], i.category_id in ^ids)
  end

  defp apply_filter(query, {field, :inclusion}, value) do
    field = String.to_existing_atom(field)
    where(query, [i], ^value in field(i, ^field))
  end

  defp apply_filter(query, {field, :like}, value) do
    field = String.to_existing_atom(field)
    value = "%#{value}%"
    where(query, [i], ilike(field(i, ^field), ^value))
  end

  defp apply_filter(query, {field, :match}, value) do
    field = String.to_existing_atom(field)
    where(query, [i], field(i, ^field) == ^value)
  end
end
