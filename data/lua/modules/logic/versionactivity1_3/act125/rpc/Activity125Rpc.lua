module("modules.logic.versionactivity1_3.act125.rpc.Activity125Rpc", package.seeall)

slot0 = class("Activity125Rpc", BaseRpc)

function slot0.sendGetAct125InfosRequest(slot0, slot1)
	slot2 = Activity125Module_pb.GetAct125InfosRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct125InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity125Model.instance:setActivityInfo(slot2)
		Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
	end
end

function slot0.sendFinishAct125EpisodeRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity125Module_pb.FinishAct125EpisodeRequest()
	slot4.activityId = slot1
	slot4.episodeId = slot2
	slot4.targetFrequency = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveFinishAct125EpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity125Model.instance:refreshActivityInfo(slot2)
		Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
		Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeFinished, slot2.episodeId)
	end
end

slot0.instance = slot0.New()

return slot0
