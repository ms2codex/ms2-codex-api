defmodule Codex.Items do
  alias Codex.{Item, ItemCategory, ItemFilter, Repo}

  @categories ItemCategory.load()

  def search(params) do
    Item
    |> ItemFilter.filter(Map.to_list(params))
    |> Repo.paginate(params)
  end

  def create(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def get(id), do: Repo.get(Item, id)

  def get_by(attrs), do: Repo.get_by(Item, attrs)

  def get_category_id(category) do
    category = String.to_existing_atom(category)
    Keyword.get(@categories, category)
  rescue
    _ ->
      nil
  end

  def categories(), do: @categories
end
