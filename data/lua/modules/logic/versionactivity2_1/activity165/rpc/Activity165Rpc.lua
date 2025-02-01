module("modules.logic.versionactivity2_1.activity165.rpc.Activity165Rpc", package.seeall)

slot0 = class("Activity165Rpc", BaseRpc)

function slot0.onReceiveAct165StoryInfo(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity165Model.instance:onGetStoryInfo(slot2)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165StoryInfo, slot2)
	end
end

function slot0.sendAct165GetInfoRequest(slot0, slot1)
	slot2 = Activity165Module_pb.Act165GetInfoRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct165GetInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity165Model.instance:onGetInfo(slot2.activityId, slot2.storyInfos)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GetInfoReply, slot2)
		Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
	end
end

function slot0.sendAct165ModifyKeywordRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity165Module_pb.Act165ModifyKeywordRequest()
	slot4.activityId = slot1
	slot4.storyId = slot2

	for slot8, slot9 in pairs(slot3) do
		slot4.keywordIds:append(slot9)
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveAct165ModifyKeywordReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity165Model.instance:onModifyKeywordCallback(slot2.activityId, slot2.storyInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165ModifyKeywordReply, slot2)
	end
end

function slot0.sendAct165GenerateEndingRequest(slot0, slot1, slot2)
	slot3 = Activity165Module_pb.Act165GenerateEndingRequest()
	slot3.activityId = slot1
	slot3.storyId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct165GenerateEndingReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity165Model.instance:onGenerateEnding(slot2.activityId, slot2.storyId, slot2.endingInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GenerateEndingReply, slot2)
	end
end

function slot0.sendAct165RestartRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity165Module_pb.Act165RestartRequest()
	slot4.activityId = slot1
	slot4.storyId = slot2
	slot4.stepId = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveAct165RestartReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity165Model.instance:onRestart(slot2.activityId, slot2.storyInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165RestartReply, slot2)
	end
end

function slot0.sendAct165GainMilestoneRewardRequest(slot0, slot1, slot2)
	slot3 = Activity165Module_pb.Act165GainMilestoneRewardRequest()
	slot3.activityId = slot1
	slot3.storyId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct165GainMilestoneRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity165Model.instance:onGetReward(slot2.activityId, slot2.storyId, slot2.gainedEndingCount)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GainMilestoneRewardReply, slot2)
		Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
	end
end

slot0.instance = slot0.New()

return slot0
