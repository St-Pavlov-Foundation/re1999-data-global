module("modules.logic.sdk.rpc.Activity1000Rpc", package.seeall)

slot0 = class("Activity1000Rpc", BaseRpc)

function slot0.sendAct1000GetInfoRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity1000Module_pb.Act1000GetInfoRequest()
	slot5.activityId = slot1

	slot0:sendMsg(slot5, slot2, slot3, slot4)
end

function slot0.onReceiveAct1000GetInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(slot2.accountBindBonus)
end

function slot0.sendAct1000AccountBindBonusRequest(slot0, slot1)
	slot2 = Activity1000Module_pb.Act1000AccountBindBonusRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct1000AccountBindBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(SDKEnum.RewardType.Got)
end

slot0.instance = slot0.New()

return slot0
