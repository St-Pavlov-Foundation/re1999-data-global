module("modules.logic.versionactivity2_5.act187.rpc.Activity187Rpc", package.seeall)

slot0 = class("Activity187Rpc", BaseRpc)

function slot0.sendGet187InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity187Module_pb.Get187InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet187InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if not Activity187Model.instance:checkActId(slot2.activityId) then
		return
	end

	Activity187Model.instance:setAct187Info(slot2)
	Activity187Controller.instance:dispatchEvent(Activity187Event.GetAct187Info)
end

function slot0.sendAct187FinishGameRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity187Module_pb.Act187FinishGameRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct187FinishGameReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if not Activity187Model.instance:checkActId(slot2.activityId) then
		return
	end

	Activity187Model.instance:setRemainPaintingCount(slot2.haveGameCount)
	Activity187Model.instance:setFinishPaintingIndex(slot2.finishGameCount)
	Activity187Model.instance:setPaintingRewardList(slot2.finishGameCount, slot2.randomBonusList)
	Activity187Controller.instance:dispatchEvent(Activity187Event.FinishPainting, slot2.finishGameCount)
end

function slot0.sendAct187AcceptRewardRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity187Module_pb.Act187AcceptRewardRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct187AcceptRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if not Activity187Model.instance:checkActId(slot2.activityId) then
		return
	end

	Activity187Controller.instance:dispatchEvent(Activity187Event.GetAccrueReward, MaterialRpc.receiveMaterial({
		dataList = slot2.fixBonusList
	}))
	Activity187Model.instance:setAccrueRewardIndex(slot2.acceptRewardGameCount)
	Activity187Controller.instance:dispatchEvent(Activity187Event.RefreshAccrueReward)
end

slot0.instance = slot0.New()

return slot0
