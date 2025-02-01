module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordEventGroupMO", package.seeall)

slot0 = pureTable("AiZiLaRecordEventGroupMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.lockDesc = slot2 or ""
	slot0._eventMOList = {}
	slot0._recordCfg = slot3
end

function slot0.addEventMO(slot0, slot1)
	table.insert(slot0._eventMOList, slot1)
end

function slot0.isUnLock(slot0)
	if slot0:getFinishedEventMO() then
		return true
	end

	return false
end

function slot0.getFinishedEventMO(slot0)
	for slot4, slot5 in ipairs(slot0._eventMOList) do
		if slot5:isFinished() then
			return slot5
		end
	end
end

function slot0.isHasRed(slot0)
	for slot4, slot5 in ipairs(slot0._eventMOList) do
		if slot5:isHasRed() then
			return true
		end
	end

	return false
end

function slot0.finishRed(slot0)
	for slot4, slot5 in ipairs(slot0._eventMOList) do
		if slot5:isFinished() then
			slot5:finishRed()
		end
	end
end

function slot0.getRedUid(slot0)
	slot1 = slot0:getFinishedEventMO() or slot0._eventMOList[1]

	return slot1 and slot1:getRedUid() or slot0.id
end

function slot0.getLockDesc(slot0)
	return (string.split(slot0._recordCfg.unLockDesc, "|") or {})[slot0.id] or ""
end

return slot0
