module("modules.logic.activity.rpc.ActivityRpc", package.seeall)

slot0 = class("ActivityRpc", BaseRpc)

function slot0.sendGetActivityInfosRequest(slot0, slot1, slot2)
	return slot0:sendMsg(ActivityModule_pb.GetActivityInfosRequest(), slot1, slot2)
end

function slot0.onReceiveGetActivityInfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityModel.instance:setActivityInfo(slot2)
		ActivityController.instance:checkGetActivityInfo()
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState)
	end
end

function slot0.onReceiveUpdateActivityPush(slot0, slot1, slot2)
	if slot1 == 0 then
		ServerTime.update(slot2.time)
		ActivityModel.instance:updateActivityInfo(slot2.activityInfo)
		ActivityController.instance:updateAct101Infos(slot2.activityInfo.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, slot2.activityInfo.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.UpdateActivity, slot2.activityInfo.id)
	end
end

function slot0.onReceiveEndActivityPush(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityModel.instance:endActivity(slot2.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, slot2.id)
	end
end

function slot0.sendActivityNewStageReadRequest(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if ActivityModel.instance:getActivityInfo()[slot9] and slot10:isNewStageOpen() then
			table.insert(slot4, slot9)
		end
	end

	if #slot4 < 1 then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	slot5 = ActivityModule_pb.ActivityNewStageReadRequest()

	for slot9, slot10 in pairs(slot4) do
		if slot10 ~= ActivityEnum.PlaceholderActivityId then
			table.insert(slot5.id, slot10)
		end
	end

	return slot0:sendMsg(slot5, slot2, slot3)
end

function slot0.onReceiveActivityNewStageReadReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
	end
end

function slot0.sendUnlockPermanentRequest(slot0, slot1, slot2, slot3)
	slot4 = ActivityModule_pb.UnlockPermanentRequest()
	slot4.id = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveUnlockPermanentReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityModel.instance:setPermanentUnlock(slot2.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.UnlockPermanent, slot2.id)
	end
end

function slot0.sendGetActivityInfosWithParamRequest(slot0, slot1)
	slot2 = ActivityModule_pb.GetActivityInfosWithParamRequest()

	for slot6, slot7 in ipairs(slot1 or {}) do
		table.insert(slot2.activityIds, slot7)
	end

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGetActivityInfosWithParamReply(slot0, slot1, slot2)
	if slot1 == 0 then
		for slot6, slot7 in ipairs(slot2.activityInfos) do
			ActivityModel.instance:updateInfoNoRepleace(slot7)
		end

		ActivityController.instance:dispatchEvent(ActivityEvent.GetActivityInfoWithParamSuccess)
	end
end

slot0.instance = slot0.New()

return slot0
