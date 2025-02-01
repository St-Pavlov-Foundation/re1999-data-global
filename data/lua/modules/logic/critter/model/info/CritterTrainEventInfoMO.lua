module("modules.logic.critter.model.info.CritterTrainEventInfoMO", package.seeall)

slot0 = pureTable("CritterTrainEventInfoMO")
slot1 = {}

function slot0.init(slot0, slot1)
	slot1 = slot1 or uv0
	slot0.eventId = slot1.eventId or 0
	slot0.remainCount = slot1.remainCount or 0
	slot0.finishCount = slot1.finishCount or 0
	slot0.activeTime = slot1.activeTime or slot0.activeTime or 0
	slot0.addAttributes = CritterHelper.getInitClassMOList(slot1.addAttributes, CritterAttributeMO, slot0.addAttributes)
	slot0.options = CritterHelper.getInitClassMOList(slot1.options, CritterTrainOptionInfoMO, slot0.options)

	slot0:_updateDefineCfg()
end

function slot0.setTrainInfoMO(slot0, slot1)
	slot0._trainInfoMO = slot1
end

function slot0._updateDefineCfg(slot0)
	if slot0._lastEventId ~= slot0.eventId then
		slot0.config = CritterConfig.instance:getCritterTrainEventCfg(slot0.eventId, slot0.eventId ~= 0)
		slot0.conditionNums = slot0:_splitToNumer(slot0.config and slot0.config.condition)
		slot0.effectAttributeNums = slot0:_splitToNumer(slot0.config and slot0.config.effectAttribute)
		slot0.eventType = slot0.config and slot0.config.type or 0
	end
end

function slot0._splitToNumer(slot0, slot1)
	if not string.nilorempty(slot1) then
		return string.splitToNumber(slot1, "#")
	end
end

function slot0.getDefineCfg(slot0)
	return slot0.config
end

function slot0.getConditionTime(slot0)
	if slot0.conditionNums then
		return slot0.conditionNums[2] or 0
	end

	return 0
end

function slot0.getEventType(slot0)
	return slot0.eventType or 0
end

function slot0.getFinishCount(slot0)
	return slot0.finishCount or 0
end

function slot0.isHasEventAction(slot0)
	if slot0:isEventFinish() then
		return false
	end

	if slot0:isEventActive() then
		return true
	end

	return false
end

function slot0.isEventActive(slot0)
	if (slot0.eventType == CritterEnum.EventType.Special or slot0.eventType == CritterEnum.EventType.ActiveTime) and (slot0.remainCount and slot0.remainCount > 0 or slot0.finishCount and slot0.finishCount > 0) then
		return true
	end

	return false
end

function slot0.getTrainProcessTime(slot0)
	if slot0._trainInfoMO then
		return slot0._trainInfoMO:getProcessTime()
	end

	return 0
end

function slot0.isEventFinish(slot0)
	if slot0.remainCount and slot0.remainCount <= 0 then
		if slot0.eventType == CritterEnum.EventType.ActiveTime and slot0.finishCount and slot0.finishCount <= 0 then
			return false
		end

		return true
	end

	return false
end

function slot0.getEventInfoOption(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.options) do
		if slot6.optionId == slot1 then
			return slot6
		end
	end
end

return slot0
