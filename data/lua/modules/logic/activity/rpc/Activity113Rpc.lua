module("modules.logic.activity.rpc.Activity113Rpc", package.seeall)

slot0 = class("Activity113Rpc", BaseRpc)

function slot0.sendGetAct113InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity113Module_pb.GetAct113InfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct113InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

slot0.instance = slot0.New()

return slot0
