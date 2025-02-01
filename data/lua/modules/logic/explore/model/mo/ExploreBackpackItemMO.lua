module("modules.logic.explore.model.mo.ExploreBackpackItemMO", package.seeall)

slot0 = pureTable("ExploreBackpackItemMO")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.ids = {}
	slot0.quantity = 0
	slot0.itemId = 0
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.uid
	slot0.ids = {
		slot0.id
	}
	slot0.quantity = slot1.quantity
	slot0.itemId = slot1.itemId
	slot0.status = slot1.status
	slot0.config = ExploreConfig.instance:getItemCo(slot0.itemId)
	slot0.isStackable = slot0.config.isClientStackable
	slot0.isActiveTypeItem = ExploreConfig.instance:isActiveTypeItem(slot0.config.type)
	slot0.itemEffect = string.split(slot0.config.effect, "#")[1] or "1"
end

function slot0.updateStackable(slot0, slot1)
	if slot1.quantity == 0 then
		tabletool.removeValue(slot0.ids, slot1.uid)
	elseif tabletool.indexOf(slot0.ids, slot1.uid) == nil then
		table.insert(slot0.ids, slot1.uid)
	end

	slot0.id = slot0.ids[1] or 0
	slot0.quantity = #slot0.ids
end

return slot0
