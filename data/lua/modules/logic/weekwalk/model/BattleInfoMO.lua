module("modules.logic.weekwalk.model.BattleInfoMO", package.seeall)

slot0 = pureTable("BattleInfoMO")

function slot0.init(slot0, slot1)
	slot0.battleId = slot1.battleId
	slot0.star = slot1.star
	slot0.maxStar = slot1.maxStar
	slot0.heroIds = {}
	slot0.heroGroupSelect = slot1.heroGroupSelect or 0
	slot0.elementId = slot1.elementId

	for slot5, slot6 in ipairs(slot1.heroIds) do
		table.insert(slot0.heroIds, slot6)
	end
end

function slot0.setIndex(slot0, slot1)
	slot0.index = slot1
end

return slot0
