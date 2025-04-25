module("modules.logic.versionactivity2_5.feilinshiduo.rpc.Activity185Rpc", package.seeall)

slot0 = class("Activity185Rpc", BaseRpc)

function slot0.sendGetAct185InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity185Module_pb.GetAct185InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct185InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	FeiLinShiDuoModel.instance:initEpisodeFinishInfo(slot2)
end

function slot0.sendAct185FinishEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity185Module_pb.Act185FinishEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct185FinishEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.episodeId

	FeiLinShiDuoModel.instance:setCurFinishEpisodeId(slot4)
	FeiLinShiDuoModel.instance:updateEpisodeFinishState(slot4, true)
end

function slot0.onReceiveAct185EpisodePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	FeiLinShiDuoModel.instance:initEpisodeFinishInfo(slot2)
	FeiLinShiDuoModel.instance:setNewUnlockEpisode(slot2)
end

slot0.instance = slot0.New()

return slot0
