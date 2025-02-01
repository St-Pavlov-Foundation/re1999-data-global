module("modules.logic.summon.model.SummonCustomPickMO", package.seeall)

slot0 = pureTable("SummonCustomPickMO")

function slot0.ctor(slot0)
	slot0.pickHeroIds = nil
end

function slot0.update(slot0, slot1)
	slot0.pickHeroIds = {}

	if slot1.UpHeroIds then
		for slot5 = 1, #slot1.UpHeroIds do
			table.insert(slot0.pickHeroIds, slot1.UpHeroIds[slot5])
		end
	end
end

function slot0.isPicked(slot0, slot1)
	return slot0.pickHeroIds ~= nil and SummonCustomPickModel.instance:getMaxSelectCount(slot1) <= #slot0.pickHeroIds
end

return slot0
