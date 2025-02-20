module("modules.logic.act189.model.Activity189Model", package.seeall)

slot0 = class("Activity189Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._actInfo = {}
end

function slot0.getActMO(slot0, slot1)
	return ActivityModel.instance:getActMO(slot1)
end

function slot0.getRealStartTimeStamp(slot0, slot1)
	return slot0:getActMO(slot1):getRealStartTimeStamp()
end

function slot0.getRealEndTimeStamp(slot0, slot1)
	return slot0:getActMO(slot1):getRealEndTimeStamp()
end

function slot0.getRemainTimeSec(slot0, slot1)
	return ActivityModel.instance:getRemainTimeSec(slot1) or 0
end

function slot0.onReceiveGetAct189InfoReply(slot0, slot1)
	slot0._actInfo[slot1.activityId] = slot1
end

function slot0.onReceiveGetAct189OnceBonusReply(slot0, slot1)
	if not slot0._actInfo[slot1.activityId] then
		return
	end

	rawset(slot2, "hasGetOnceBonus", true)
end

function slot0.isClaimed(slot0, slot1)
	if not slot0._actInfo[slot1] then
		return false
	end

	return slot2.hasGetOnceBonus
end

function slot0.isClaimable(slot0, slot1)
	if not slot0._actInfo[slot1] then
		return false
	end

	return not slot0:isClaimed(slot1)
end

slot0.instance = slot0.New()

return slot0
