module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordEventMO", package.seeall)

slot0 = pureTable("AiZiLaRecordEventMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.eventId
	slot0.eventId = slot1.eventId
	slot0.config = slot1
	slot0._actId = slot1.activityId

	if slot1 and not string.nilorempty(slot1.optionIds) then
		slot0._optionIds = string.splitToNumber(slot1.optionIds, "|")
	end

	slot0._optionIds = slot0._optionIds or {}
	slot0._redPointKey = AiZiLaHelper.getRedKey(RedDotEnum.DotNode.V1a5AiZiLaRecordEventNew, slot0.eventId)
end

function slot0.isFinished(slot0)
	if not AiZiLaModel.instance:isSelectEventId(slot0.eventId) then
		return false
	end

	for slot5, slot6 in ipairs(slot0._optionIds) do
		if slot1:isSelectOptionId(slot6) then
			return true
		end
	end

	return false
end

function slot0.getSelectOptionCfg(slot0)
	for slot6, slot7 in ipairs(slot0._optionIds) do
		if AiZiLaModel.instance:isSelectOptionId(slot7) and AiZiLaConfig.instance:getOptionCo(slot0._actId, slot7) then
			return slot8
		end
	end
end

function slot0.isHasRed(slot0)
	if slot0:isFinished() and not AiZiLaHelper.isFinishRed(slot0._redPointKey) then
		return true
	end

	return false
end

function slot0.finishRed(slot0)
	AiZiLaHelper.finishRed(slot0._redPointKey, true)
end

function slot0.getRedUid(slot0)
	return slot0.eventId
end

return slot0
