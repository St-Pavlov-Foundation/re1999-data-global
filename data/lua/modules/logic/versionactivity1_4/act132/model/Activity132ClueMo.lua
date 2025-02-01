module("modules.logic.versionactivity1_4.act132.model.Activity132ClueMo", package.seeall)

slot0 = class("Activity132ClueMo")

function slot0.ctor(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.clueId = slot1.clueId
	slot0.name = slot1.name
	slot0.contentDict = {}
	slot0.posX = string.splitToNumber(slot1.pos, "#")[1] or 0
	slot0.posY = slot2[2] or 0

	for slot7, slot8 in ipairs(string.splitToNumber(slot1.contents, "#")) do
		if Activity132Config.instance:getContentConfig(slot0.activityId, slot8) then
			slot0.contentDict[slot8] = Activity132ContentMo.New(slot9)
		end
	end

	slot0._cfg = slot1
end

function slot0.getContentList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.contentDict) do
		table.insert(slot1, slot6)
	end

	if #slot1 > 1 then
		table.sort(slot1, SortUtil.keyLower("contentId"))
	end

	return slot1
end

function slot0.getPos(slot0)
	return slot0.posX, slot0.posY
end

function slot0.getName(slot0)
	return slot0._cfg.name
end

return slot0
