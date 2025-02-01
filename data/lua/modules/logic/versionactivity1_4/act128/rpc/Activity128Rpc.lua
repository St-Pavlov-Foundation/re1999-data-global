module("modules.logic.versionactivity1_4.act128.rpc.Activity128Rpc", package.seeall)

slot0 = class("Activity128Rpc", BaseRpc)

function slot0.sendGet128InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity128Module_pb.Get128InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet128InfosReply(slot0, slot1, slot2)
	slot0:_onReceiveGet128InfosReply(slot1, slot2)
end

function slot0.sendAct128GetTotalRewardsRequest(slot0, slot1, slot2)
	slot3 = Activity128Module_pb.Act128GetTotalRewardsRequest()
	slot3.activityId = slot1
	slot3.bossId = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveAct128GetTotalRewardsReply(slot0, slot1, slot2)
	slot0:_onReceiveAct128GetTotalRewardsReply(slot1, slot2)
end

function slot0.sendAct128DoublePointRequest(slot0, slot1, slot2)
	slot3 = Activity128Module_pb.Act128DoublePointRequest()
	slot3.activityId = slot1
	slot3.bossId = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveAct128DoublePointReply(slot0, slot1, slot2)
	slot0:_onReceiveAct128DoublePointReply(slot1, slot2)
end

function slot0.onReceiveAct128InfoUpdatePush(slot0, slot1, slot2)
	slot0:_onReceiveAct128InfoUpdatePush(slot1, slot2)
end

function slot0.sendAct128EvaluateRequest(slot0, slot1, slot2)
end

function slot0.sendAct128GetTotalSingleRewardRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity128Module_pb.Act128GetTotalSingleRewardRequest()
	slot4.activityId = slot1
	slot4.bossId = slot2
	slot4.rewardId = slot3

	return slot0:sendMsg(slot4)
end

function slot0.onReceiveAct128GetTotalSingleRewardReply(slot0, slot1, slot2)
	slot0:_onReceiveAct128GetTotalSingleRewardReply(slot1, slot2)
end

return slot0
