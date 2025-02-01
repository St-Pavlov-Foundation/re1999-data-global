module("modules.logic.versionactivity1_5.act146.rpc.Activity146Rpc", package.seeall)

slot0 = class("Activity146Rpc", BaseRpc)

function slot0.sendGetAct146InfosRequest(slot0, slot1)
	slot2 = Activity146Module_pb.GetAct146InfosRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct146InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity146Model.instance:setActivityInfo(slot2.act146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

function slot0.sendFinishAct146EpisodeRequest(slot0, slot1, slot2)
	slot3 = Activity146Module_pb.FinishAct146EpisodeRequest()
	slot3.activityId = slot1
	slot3.episodeId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveFinishAct146EpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity146Model.instance:setActivityInfo(slot2.updateAct146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

function slot0.sendAct146EpisodeBonusRequest(slot0, slot1, slot2)
	slot3 = Activity146Module_pb.Act146EpisodeBonusRequest()
	slot3.activityId = slot1
	slot3.episodeId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct146EpisodeBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity146Model.instance:setActivityInfo(slot2.updateAct146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

slot0.instance = slot0.New()

return slot0
