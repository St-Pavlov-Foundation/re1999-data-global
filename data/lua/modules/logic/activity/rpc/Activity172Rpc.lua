module("modules.logic.activity.rpc.Activity172Rpc", package.seeall)

slot0 = class("Activity172Rpc", BaseRpc)

function slot0.sendGetAct172InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity172Module_pb.GetAct172InfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct172InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ActivityType172Model.instance:setType172Info(slot2.activityId, slot2.info)
end

function slot0.onReceiveAct172UseItemTaskIdsUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ActivityType172Model.instance:updateType172Info(slot2.activityId, slot2.useItemTaskIds)
	ActivityController.instance:dispatchEvent(ActivityEvent.Act172TaskUpdate)
end

slot0.instance = slot0.New()

return slot0
