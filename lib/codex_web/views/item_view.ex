defmodule CodexWeb.ItemView do
  use CodexWeb, :view
  alias CodexWeb.ItemView

  def render("index.json", %{page: page}) do
    %{
      page: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages,
      data: render_many(page, ItemView, "item.json")
    }
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("categories.json", %{categories: categories}) do
    %{data: Enum.map(categories, fn {name, id} -> %{id: id, name: name} end)}
  end

  def render("item.json", %{item: item}) do
    Map.take(item, [
      :id,
      :item_id,
      :name,
      :category_id,
      :rarity,
      :is_two_handed,
      :is_dress,
      :jobs,
      :slot,
      :gem_slot,
      :tab
    ])
  end
end
