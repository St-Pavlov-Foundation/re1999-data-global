module("modules.logic.activitywelfare.model.Activity160Model", package.seeall)

slot0 = class("Activity160Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.infoDic = {}
end

function slot0.setInfo(slot0, slot1)
	for slot7, slot8 in ipairs(slot1.act160Infos) do
		slot0:getActInfo(slot1.activityId)[slot8.id] = slot8
	end

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, slot2)
end

function slot0.updateInfo(slot0, slot1)
	slot2 = slot1.activityId
	slot0:getActInfo(slot2)[slot1.act160Info.id] = slot1.act160Info

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, slot2)
end

function slot0.finishMissionReply(slot0, slot1)
	slot2 = slot1.activityId
	slot0:getActInfo(slot2)[slot1.act160Info.id] = slot1.act160Info

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, slot2)

	if slot1.isReadMail then
		Activity160Controller.instance:dispatchEvent(Activity160Event.HasReadMail, slot2, slot1.act160Info.id)
	end
end

function slot0.getActInfo(slot0, slot1)
	if not slot0.infoDic[slot1] then
		slot0.infoDic[slot1] = {}
	end

	return slot0.infoDic[slot1]
end

function slot0.getCurMission(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getActInfo(slot1)) do
		if slot7.state ~= 2 then
			return slot6
		end
	end

	return slot2[#slot2].id
end

function slot0.hasRewardClaim(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getActInfo(slot1)) do
		if slot7.state == 1 then
			return true
		end
	end

	return false
end

function slot0.hasRewardCanGet(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getActInfo(slot1)) do
		if slot7.state ~= 2 then
			return true
		end
	end

	return false
end

function slot0.isMissionCanGet(slot0, slot1, slot2)
	return slot0:getActInfo(slot1)[slot2] and slot3[slot2].state == 1
end

function slot0.isMissionFinish(slot0, slot1, slot2)
	return slot0:getActInfo(slot1)[slot2] and slot3[slot2].state == 2
end

slot0.instance = slot0.New()

return slot0
