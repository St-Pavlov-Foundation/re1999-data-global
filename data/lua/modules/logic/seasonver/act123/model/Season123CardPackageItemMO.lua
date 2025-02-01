slot0 = pureTable("Season123CardPackageItemMO")

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.itemId = slot1
	slot0.count = 1
	slot0.config = Season123Config.instance:getSeasonEquipCo(slot1)
end

return slot0
