module("modules.logic.herogroup.model.HeroGroupEquipMO", package.seeall)

slot0 = pureTable("HeroGroupEquipMO")

function slot0.init(slot0, slot1)
	slot0.index = slot1.index
	slot0.equipUid = {}

	for slot5 = 1, 1 do
		table.insert(slot0.equipUid, "0")
	end

	if not slot1.equipUid then
		return
	end

	for slot5, slot6 in ipairs(slot1.equipUid) do
		if slot5 > 1 then
			break
		end

		slot0.equipUid[slot5] = slot6
	end
end

return slot0
