module("modules.logic.versionactivity1_4.act136.rpc.Activity136Rpc", package.seeall)

slot0 = class("Activity136Rpc", BaseRpc)

function slot0.sendGet136InfoRequest(slot0, slot1)
	slot2 = Activity136Module_pb.Get136InfoRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGet136InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity136Model.instance:setActivityInfo(slot2)
	end
end

function slot0.sendAct136SelectRequest(slot0, slot1, slot2)
	slot3 = Activity136Module_pb.Act136SelectRequest()
	slot3.activityId = slot1
	slot3.selectHeroId = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveAct136SelectReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity136Model.instance:setActivityInfo(slot2)
		Activity136Controller.instance:confirmReceiveCharacterCallback()
	end
end

slot0.instance = slot0.New()

return slot0
