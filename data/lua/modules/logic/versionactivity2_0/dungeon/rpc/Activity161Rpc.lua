module("modules.logic.versionactivity2_0.dungeon.rpc.Activity161Rpc", package.seeall)

slot0 = class("Activity161Rpc", BaseRpc)

function slot0.sendAct161GetInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity161Module_pb.Act161GetInfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct161GetInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity161Model.instance:setGraffitiInfo(slot2)
		Activity161Controller.instance:checkGraffitiCdInfo()
	end
end

function slot0.sendAct161RefreshElementsRequest(slot0, slot1)
	slot2 = Activity161Module_pb.Act161RefreshElementsRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct161RefreshElementsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity161Controller.instance:dispatchEvent(Activity161Event.RefreshGraffitiView)

		if Activity161Model.instance.isNeedRefreshNewElement then
			DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
		end
	end
end

function slot0.sendAct161GainMilestoneRewardRequest(slot0, slot1)
	slot2 = Activity161Module_pb.Act161GainMilestoneRewardRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct161GainMilestoneRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity161Model.instance:setRewardInfo(slot2)
		Activity161Controller.instance:dispatchEvent(Activity161Event.GetGraffitiReward)
	end
end

function slot0.onReceiveAct161CdBeginPush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity161Model.instance:setGraffitiInfo(slot2)
		Activity161Controller.instance:checkGraffitiCdInfo()
	end
end

slot0.instance = slot0.New()

return slot0
