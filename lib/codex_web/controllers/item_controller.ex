defmodule CodexWeb.ItemController do
  use CodexWeb, :controller

  alias Codex.Items

  action_fallback CodexWeb.FallbackController

  def index(conn, params) do
    page = Items.search(params)
    render(conn, "index.json", page: page)
  end

  def show(conn, %{"id" => id}) do
    item = Items.get(id)
    render(conn, "show.json", item: item)
  end

  def categories(conn, _params) do
    render(conn, "categories.json", categories: Items.categories())
  end
end
