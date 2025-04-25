module("modules.logic.critter.model.info.CritterTrainInfoMO", package.seeall)

slot0 = pureTable("CritterTrainInfoMO")
slot1 = {}

function slot0.init(slot0, slot1)
	slot1 = slot1 or uv0
	slot0.heroId = slot1.heroId or 0
	slot0.startTime = slot1.startTime or 0
	slot0.endTime = slot1.endTime or 0
	slot0.fastForwardTime = slot1.fastForwardTime or 0
	slot0.trainTime = slot1.trainTime or slot0.trainTime or 0
	slot0.events = CritterHelper.getInitClassMOList(slot1.events, CritterTrainEventInfoMO, slot0.events)
	slot0.eventTimePoints = slot0.eventTimePoints or {}

	slot0:updateEventActiveTime()
end

function slot0.updateEventActiveTime(slot0)
	slot1 = 0
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.events) do
		if slot7:getEventType() == CritterEnum.EventType.ActiveTime then
			slot0.eventTimePoints[slot2 + 1] = slot1
			slot1 = slot1 + slot7:getConditionTime()
		end

		slot7:setTrainInfoMO(slot0)
	end

	if slot2 < #slot0.eventTimePoints then
		while slot2 < #slot0.eventTimePoints do
			table.remove(slot0.eventTimePoints, #slot0.eventTimePoints)
		end
	end
end

function slot0.setCritterMO(slot0, slot1)
	slot0._critterMO = slot1
end

function slot0.isTraining(slot0)
	if slot0.heroId and slot0.heroId ~= 0 then
		return slot0.startTime + slot0.fastForwardTime < slot0.endTime
	end

	return false
end

function slot0.isTrainFinish(slot0)
	if slot0.heroId and slot0.heroId ~= 0 then
		return slot0:getCurCdTime() <= 0
	end

	return false
end

function slot0.isCultivating(slot0)
	if slot0.trainInfo.heroId and slot0.trainInfo.heroId ~= 0 and (slot0:getCurCdTime() > 0 or slot0._critterMO.finishTrain ~= true) then
		return true
	end

	return false
end

function slot0.isHasEventTrigger(slot0)
	for slot4 = 1, #slot0.events do
		if CritterEnum.NeedActionEventTypeDict[slot0.events[slot4]:getEventType()] and slot5:isHasEventAction() then
			return true
		end
	end

	return false
end

function slot0.checkRoundFinish(slot0, slot1, slot2)
	for slot6 = 1, #slot0.events do
		slot7 = slot0.events[slot6]

		if (slot2 == nil or slot7:getEventType() == slot2) and slot7:getFinishCount() < slot1 then
			return false
		end
	end

	return true
end

function slot0.getTotalTime(slot0)
	return slot0.endTime - slot0.startTime
end

function slot0.getProcessTime(slot0)
	if slot0.trainTime < ServerTime.now() - slot0.startTime + slot0.fastForwardTime then
		return slot0.trainTime
	end

	return slot2
end

function slot0.getCurCdTime(slot0)
	if slot0.trainTime - slot0:getProcessTime() < 0 then
		return 0
	end

	return slot1
end

function slot0.getProcess(slot0)
	if slot0.endTime ~= 0 then
		slot1 = slot0:getProcessTime()

		if slot0.trainTime > 0 and slot1 > 0 then
			return slot1 / slot2
		end
	end

	return 0
end

function slot0.isFinishAllEvent(slot0)
	for slot4, slot5 in ipairs(slot0.events) do
		if CritterEnum.NeedActionEventTypeDict[slot5:getEventType()] and not slot5:isEventFinish() then
			return false
		end
	end

	return true
end

function slot0.selectFinishEvent(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.events) do
		if slot6.eventId == slot1 then
			slot6.remainCount = slot6.remainCount - 1
			slot6.finishCount = slot6.finishCount + 1
		end
	end
end

function slot0.getEvents(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.events) do
		if slot6.eventId == slot1 then
			return slot6
		end
	end
end

function slot0.getEventOptions(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.events) do
		if slot6.eventId == slot1 then
			return slot6.options
		end
	end
end

function slot0.getEventOptionMOByOptionId(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.events) do
		if slot7.eventId == slot1 then
			return slot7:getEventInfoOption(slot2)
		end
	end
end

function slot0.getAddAttributeValue(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.events) do
		for slot11, slot12 in ipairs(slot7.addAttributes) do
			if slot12.attributeId == slot1 then
				slot2 = slot2 + slot12.value
			end
		end
	end

	return slot2
end

return slot0
