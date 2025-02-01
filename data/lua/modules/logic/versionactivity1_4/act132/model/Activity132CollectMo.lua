module("modules.logic.versionactivity1_4.act132.model.Activity132CollectMo", package.seeall)

slot0 = class("Activity132CollectMo")

function slot0.ctor(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.collectId = slot1.collectId
	slot0.name = slot1.name
	slot0.bg = slot1.bg
	slot0.nameEn = slot1.nameEn
	slot0.clueDict = {}

	for slot6, slot7 in ipairs(string.splitToNumber(slot1.clues, "#")) do
		slot9 = Activity132Config.instance:getClueConfig(slot0.activityId, slot7)

		if not slot0.clueDict[slot7] and slot9 then
			slot0.clueDict[slot7] = Activity132ClueMo.New(slot9)
		end
	end

	slot0._cfg = slot1
end

function slot0.getClueList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.clueDict) do
		table.insert(slot1, slot6)
	end

	if #slot1 > 1 then
		table.sort(slot1, SortUtil.keyLower("clueId"))
	end

	return slot1
end

function slot0.getClueMo(slot0, slot1)
	return slot0.clueDict[slot1]
end

function slot0.getName(slot0)
	return slot0._cfg.name
end

return slot0
