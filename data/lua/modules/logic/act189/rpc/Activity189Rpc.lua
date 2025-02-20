module("modules.logic.act189.rpc.Activity189Rpc", package.seeall)

slot0 = class("Activity189Rpc", BaseRpc)

function slot0.sendGetAct189InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity189Module_pb.GetAct189InfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct189InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity189Model.instance:onReceiveGetAct189InfoReply(slot2)
		Activity189Controller.instance:dispatchEvent(Activity189Event.onReceiveGetAct189InfoReply, slot2)
	end
end

function slot0.sendGetAct189OnceBonusRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity189Module_pb.GetAct189OnceBonusRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct189OnceBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity189Model.instance:onReceiveGetAct189OnceBonusReply(slot2)
		Activity189Controller.instance:dispatchEvent(Activity189Event.onReceiveGetAct189OnceBonusReply, slot2)
	end
end

slot0.instance = slot0.New()

return slot0
