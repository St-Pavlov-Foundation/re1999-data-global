module("modules.logic.versionactivity2_5.act186.rpc.Activity186Rpc", package.seeall)

slot0 = class("Activity186Rpc", BaseRpc)

function slot0.sendGetAct186InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity186Module_pb.GetAct186InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct186InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:setActInfo(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.UpdateInfo)
	Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
end

function slot0.sendFinishAct186TaskRequest(slot0, slot1, slot2)
	slot3 = Activity186Module_pb.FinishAct186TaskRequest()
	slot3.activityId = slot1
	slot3.taskId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveFinishAct186TaskReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Task(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishTask, slot2)
end

function slot0.sendGetAct186MilestoneRewardRequest(slot0, slot1)
	slot2 = Activity186Module_pb.GetAct186MilestoneRewardRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct186MilestoneRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onGetAct186MilestoneReward(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetMilestoneReward)
end

function slot0.sendGetAct186DailyCollectionRequest(slot0, slot1)
	slot2 = Activity186Module_pb.GetAct186DailyCollectionRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct186DailyCollectionReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onGetAct186DailyCollection(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetDailyCollection)
end

function slot0.onReceiveAct186TaskPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onAct186TaskPush(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.UpdateTask)
end

function slot0.onReceiveAct186LikePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onAct186LikePush(slot2)
end

function slot0.sendFinishAct186ATypeGameRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity186Module_pb.FinishAct186ATypeGameRequest()
	slot4.activityId = slot1
	slot4.gameId = slot2
	slot4.rewardId = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveFinishAct186ATypeGameReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Game(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishGame)
end

function slot0.sendAct186BTypeGamePlayRequest(slot0, slot1, slot2)
	slot3 = Activity186Module_pb.Act186BTypeGamePlayRequest()
	slot3.activityId = slot1
	slot3.gameId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct186BTypeGamePlayReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onBTypeGamePlay(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.PlayGame)
end

function slot0.sendFinishAct186BTypeGameRequest(slot0, slot1, slot2)
	slot3 = Activity186Module_pb.FinishAct186BTypeGameRequest()
	slot3.activityId = slot1
	slot3.gameId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveFinishAct186BTypeGameReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Game(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishGame)
end

function slot0.sendGetAct186OnceBonusRequest(slot0, slot1)
	slot2 = Activity186Module_pb.GetAct186OnceBonusRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct186OnceBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity186Model.instance:onGetOnceBonusReply(slot2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetOnceBonus)
end

slot0.instance = slot0.New()

return slot0
