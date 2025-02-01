module("modules.logic.ressplit.model.VersionResSplitData", package.seeall)

slot0 = class("VersionResSplitData")

function slot0.init(slot0, slot1)
	slot0._id = slot1
	slot0._allResDict = {}
	slot0._resType2PathsDict = {}
end

function slot0.addResSplitInfo(slot0, slot1, slot2, slot3)
	if not slot3 then
		return
	end

	slot0._allResDict[slot1] = slot0._allResDict[slot1] or {}
	slot0._resType2PathsDict[slot2] = slot0._resType2PathsDict[slot2] or {}

	if not slot0._allResDict[slot1][slot3] then
		slot0._resType2PathsDict[slot2][slot3] = true
		slot0._allResDict[slot1][slot3] = true
	end
end

function slot0.checkResSplitInfo(slot0, slot1, slot2)
	return slot0._allResDict[slot1] and slot0._allResDict[slot1][slot2]
end

function slot0.checkResTypeSplitInfo(slot0, slot1, slot2)
	return slot0._resType2PathsDict[slot1] and slot0._resType2PathsDict[slot1][slot2]
end

function slot0.deleteResSplitInfo(slot0, slot1, slot2, slot3)
	if slot1 and slot0._allResDict[slot1] and slot0._allResDict[slot1][slot3] then
		slot0._allResDict[slot1][slot3] = false
	end

	if slot2 and slot0._resType2PathsDict[slot2] and slot0._resType2PathsDict[slot2][slot3] then
		slot0._resType2PathsDict[slot2][slot3] = false
	end
end

function slot0.getAllResDict(slot0)
	return slot0._allResDict
end

function slot0.getAllResTypeDict(slot0)
	return slot0._resType2PathsDict
end

function slot0.getResSplitMap(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._allResDict) do
		slot1[slot5] = slot1[slot5] or {}

		for slot10, slot11 in pairs(slot6) do
			if slot11 then
				slot12 = slot1[slot5]
				slot12[#slot12 + 1] = slot10
			end
		end
	end

	return slot1
end

function slot0.getResTypeSplitMap(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._resType2PathsDict) do
		slot1[slot5] = slot1[slot5] or {}

		for slot10, slot11 in pairs(slot6) do
			if slot11 then
				slot12 = slot1[slot5]
				slot12[#slot12 + 1] = slot10
			end
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
