module("modules.logic.versionactivity1_6.act152.rpc.Activity152Rpc", package.seeall)

slot0 = class("Activity152Rpc", BaseRpc)

function slot0.sendGet152InfoRequest(slot0, slot1)
	slot2 = Activity152Module_pb.Get152InfoRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGet152InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity152Model.instance:setActivity152Infos(slot2.presentIds)
end

function slot0.sendAct152AcceptPresentRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity152Module_pb.Act152AcceptPresentRequest()
	slot5.activityId = slot1
	slot5.presentId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct152AcceptPresentReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

slot0.instance = slot0.New()

return slot0
