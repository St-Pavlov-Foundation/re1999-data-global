module("modules.logic.voyage.rpc.Activity1001Rpc", package.seeall)

slot0 = class("Activity1001Rpc", BaseRpc)

function slot0.sendAct1001GetInfoRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity1001Module_pb.Act1001GetInfoRequest()
	slot5.activityId = slot1

	slot0:sendMsg(slot5, slot2, slot3, slot4)
end

function slot0.onReceiveAct1001GetInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VoyageController.instance:_onReceiveAct1001GetInfoReply(slot2)
end

function slot0.onReceiveAct1001UpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VoyageController.instance:_onReceiveAct1001UpdatePush(slot2)
end

slot0.instance = slot0.New()

return slot0
