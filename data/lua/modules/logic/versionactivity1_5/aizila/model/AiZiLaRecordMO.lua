module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordMO", package.seeall)

slot0 = pureTable("AiZiLaRecordMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.recordId
	slot0.config = slot1
	slot0._groupMOList = {}
	slot0._actId = slot1.activityId
	slot0._recordId = slot1.recordId
	slot0._eventMOList = {}
	slot2 = string.split(slot1.unLockDesc, "|") or {}
	slot3 = GameUtil.splitString2(slot1.eventIds, true) or {}
	slot4 = AiZiLaConfig.instance

	for slot8, slot9 in ipairs(slot3) do
		slot10 = AiZiLaRecordEventGroupMO.New()
		slot15 = slot2[slot8]

		slot10:init(slot8, slot15, slot1)

		slot14 = slot10

		table.insert(slot0._groupMOList, slot14)

		for slot14, slot15 in ipairs(slot9) do
			if slot4:getEventCo(slot0._actId, slot15) then
				slot17 = AiZiLaRecordEventMO.New()

				slot17:init(slot16)
				slot10:addEventMO(slot17)
				table.insert(slot0._eventMOList, slot17)
			else
				logError(string.format("export_事件记录 activity:%s,eventId:%s 找不到", slot0._actId, slot15))
			end
		end
	end

	if #slot3 - #slot2 > 0 then
		logError(string.format("export_事件记录 activity:%s,recordId:%s unLockDesc数量少：%s", slot0._actId, slot0._recordId, slot5))
	end
end

function slot0.isUnLock(slot0)
	for slot4, slot5 in ipairs(slot0._groupMOList) do
		if slot5:isUnLock() then
			return true
		end
	end

	return false
end

function slot0.isHasRed(slot0)
	for slot4, slot5 in ipairs(slot0._groupMOList) do
		if slot5:isHasRed() then
			return true
		end
	end

	return false
end

function slot0.finishRed(slot0)
	for slot4, slot5 in ipairs(slot0._groupMOList) do
		slot5:finishRed()
	end
end

function slot0.getRedUid(slot0)
	return slot0.id
end

function slot0.getRroupMOList(slot0)
	return slot0._groupMOList
end

function slot0.getEventMOList(slot0)
	return slot0._eventMOList
end

return slot0
