module("modules.logic.versionactivity1_7.doubledrop.rpc.Activity153Rpc", package.seeall)

slot0 = class("Activity153Rpc", BaseRpc)

function slot0.sendGet153InfosRequest(slot0, slot1)
	slot2 = Activity153Module_pb.Get153InfosRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGet153InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DoubleDropModel.instance:setActivity153Infos(slot2)
end

function slot0.onReceiveAct153CountChangePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DoubleDropModel.instance:setActivity153Infos(slot2)
end

slot0.instance = slot0.New()

return slot0
