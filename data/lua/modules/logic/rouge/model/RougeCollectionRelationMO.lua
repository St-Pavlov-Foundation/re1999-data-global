module("modules.logic.rouge.model.RougeCollectionRelationMO", package.seeall)

slot0 = pureTable("RougeCollectionRelationMO")

function slot0.init(slot0, slot1)
	slot0.effectIndex = tonumber(slot1.effectIndex)
	slot0.showType = tonumber(slot1.showType)

	slot0:updateTrueCollectionIds(slot1.trueGuids)
end

function slot0.updateTrueCollectionIds(slot0, slot1)
	slot0.trueIds = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.trueIds, tonumber(slot6))
		end
	end
end

function slot0.getTrueCollectionIds(slot0)
	return slot0.trueIds
end

return slot0
