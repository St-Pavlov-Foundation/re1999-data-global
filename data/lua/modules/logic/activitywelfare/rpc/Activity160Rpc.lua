module("modules.logic.activitywelfare.rpc.Activity160Rpc", package.seeall)

slot0 = class("Activity160Rpc", BaseRpc)

function slot0.sendGetAct160InfoRequest(slot0, slot1)
	slot2 = Activity160Module_pb.Act160GetInfoRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct160GetInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity160Model.instance:setInfo(slot2)
	end
end

function slot0.onReceiveAct160UpdatePush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity160Model.instance:updateInfo(slot2)
	end
end

function slot0.sendGetAct160FinishMissionRequest(slot0, slot1, slot2)
	slot3 = Activity160Module_pb.Act160FinishMissionRequest()
	slot3.activityId = slot1
	slot3.id = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct160FinishMissionReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity160Model.instance:finishMissionReply(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
