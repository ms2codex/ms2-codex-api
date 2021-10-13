defmodule Codex.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :category_id, :integer
      add :item_id, :integer, null: false
      add :name, :string
      add :slot, :integer, null: false
      add :gem_slot, :integer, null: false
      add :tab, :integer, null: false
      add :is_two_handed, :boolean, null: false
      add :is_dress, :boolean, null: false
      add :jobs, {:array, :string}, null: false
      add :rarity, :integer
    end
  end
end
