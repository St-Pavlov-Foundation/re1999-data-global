module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapCo", package.seeall)

slot0 = pureTable("TianShiNaNaMapCo")

function slot0.init(slot0, slot1)
	slot0.path = slot1[1]
	slot0.unitDict = {}
	slot0.nodesDict = {}

	for slot5, slot6 in ipairs(slot1[2]) do
		slot7 = TianShiNaNaMapUnitCo.New()

		slot7:init(slot6)

		slot0.unitDict[slot7.id] = slot7
	end

	for slot5, slot6 in ipairs(slot1[3]) do
		slot7 = TianShiNaNaMapNodeCo.New()

		slot7:init(slot6)

		if not slot0.nodesDict[slot7.x] then
			slot0.nodesDict[slot7.x] = {}
		end

		slot0.nodesDict[slot7.x][slot7.y] = slot7
	end
end

function slot0.getUnitCo(slot0, slot1)
	return slot0.unitDict[slot1]
end

function slot0.getNodeCo(slot0, slot1, slot2)
	if not slot0.nodesDict[slot1] then
		return
	end

	return slot0.nodesDict[slot1][slot2]
end

return slot0
