module("modules.logic.versionactivity1_6.v1a6_warmup.rpc.Activity156Rpc", package.seeall)

slot0 = class("Activity156Rpc", BaseRpc)

function slot0.sendGetAct125InfosRequest(slot0, slot1)
	slot2 = Activity125Module_pb.GetAct125InfosRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct125InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity156Model.instance:setActivityInfo(slot2.act125Episodes)
		Activity156Controller.instance:dispatchEvent(Activity156Event.DataUpdate)
	end
end

function slot0.sendFinishAct125EpisodeRequest(slot0, slot1, slot2)
	slot3 = Activity125Module_pb.FinishAct125EpisodeRequest()
	slot3.activityId = slot1
	slot3.episodeId = slot2
	slot3.targetFrequency = 0

	slot0:sendMsg(slot3)
end

function slot0.onReceiveFinishAct125EpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity156Model.instance:setActivityInfo(slot2.updateAct125Episodes)
		Activity156Controller.instance:dispatchEvent(Activity156Event.DataUpdate)
		Activity156Controller.instance:dispatchEvent(Activity156Event.EpisodeFinished, slot2.episodeId)
	end
end

slot0.instance = slot0.New()

return slot0
