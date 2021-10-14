defmodule Codex.Item do
  use Ecto.Schema

  alias Codex.Metadata

  import Ecto.Changeset
  import EctoEnum

  @equip_slots Map.to_list(Metadata.EquipSlot.mapping())
  defenum(EquipSlot, @equip_slots)

  @gem_slots Map.to_list(Metadata.GemSlot.mapping())
  defenum(GemSlot, @gem_slots)

  @inventory_tabs Map.to_list(Metadata.InventoryTab.mapping())
  defenum(InventoryTab, @inventory_tabs)

  schema "items" do
    field :item_id, :integer
    field :category_id, :integer
    field :name, :string
    field :slot, EquipSlot
    field :gem_slot, GemSlot
    field :tab, InventoryTab
    field :rarity, :integer
    field :is_two_handed, :boolean, default: false
    field :is_dress, :boolean, default: false
    field :jobs, {:array, :string}, default: []
    field :slot_icon, :string
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [
      :category_id,
      :item_id,
      :name,
      :slot,
      :gem_slot,
      :tab,
      :rarity,
      :is_two_handed,
      :is_dress,
      :jobs,
      :slot_icon
    ])
    |> validate_required([:item_id])
  end
end
