module("modules.logic.versionactivity1_4.act129.rpc.Activity129Rpc", package.seeall)

slot0 = class("Activity129Rpc", BaseRpc)

function slot0.sendGet129InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity129Module_pb.Get129InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet129InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity129Model.instance:setInfo(slot2)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnGetInfoSuccess)
end

function slot0.sendAct129LotteryRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity129Module_pb.Act129LotteryRequest()
	slot4.activityId = slot1
	slot4.poolId = slot2
	slot4.num = slot3

	return slot0:sendMsg(slot4)
end

function slot0.onReceiveAct129LotteryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity129Model.instance:onLotterySuccess(slot2)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnLotterySuccess, slot2)
end

slot0.instance = slot0.New()

return slot0
