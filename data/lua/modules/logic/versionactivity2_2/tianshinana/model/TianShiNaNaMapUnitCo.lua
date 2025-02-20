module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapUnitCo", package.seeall)

slot0 = pureTable("TianShiNaNaMapUnitCo")

function slot0.init(slot0, slot1)
	slot0.id = slot1[1]
	slot0.unitType = slot1[2]
	slot0.x = slot1[3]
	slot0.y = slot1[4]
	slot0.unitPath = slot1[5]
	slot5 = slot1[6][2]
	slot6 = slot1[6][3]
	slot0.offset = Vector3(slot1[6][1], slot5, slot6)
	slot0.specialData = slot1[7]
	slot0.dir = slot1[8]
	slot0.walkable = slot1[9]
	slot0.effects = {}

	for slot5, slot6 in ipairs(slot1[10]) do
		table.insert(slot0.effects, {
			type = slot6[1],
			param = slot6[2]
		})
	end
end

return slot0
