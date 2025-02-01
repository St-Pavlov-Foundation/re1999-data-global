module("modules.logic.toughbattle.rpc.Activity158Rpc", package.seeall)

slot0 = class("Activity158Rpc", BaseRpc)

function slot0.sendGet158InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity158Module_pb.Get158InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet158InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ToughBattleModel.instance:onGetActInfo(slot2.info)
	end
end

function slot0.sendAct158StartChallengeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity158Module_pb.Act158StartChallengeRequest()
	slot5.activityId = slot1
	slot5.difficulty = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct158StartChallengeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ToughBattleModel.instance:onGetActInfo(slot2.info)
	end
end

function slot0.sendAct158AbandonChallengeRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity158Module_pb.Act158AbandonChallengeRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct158AbandonChallengeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ToughBattleModel.instance:onGetActInfo(slot2.info)
	end
end

slot0.instance = slot0.New()

return slot0
