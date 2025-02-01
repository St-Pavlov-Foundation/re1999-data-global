module("modules.logic.story.rpc.StoryRpc", package.seeall)

slot0 = class("StoryRpc", BaseRpc)

function slot0.sendGetStoryRequest(slot0, slot1, slot2)
	return slot0:sendMsg(StoryModule_pb.GetStoryRequest(), slot1, slot2)
end

function slot0.onReceiveGetStoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		StoryModel.instance:setStoryList(slot2)
	end
end

function slot0.sendUpdateStoryRequest(slot0, slot1, slot2, slot3)
	slot4 = StoryModule_pb.UpdateStoryRequest()
	slot4.storyId = slot1
	slot4.stepId = slot2
	slot4.favor = slot3

	StoryModel.instance:updateStoryList(slot4)
	slot0:sendMsg(slot4)
end

function slot0.onReceiveUpdateStoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendGetStoryFinishRequest(slot0, slot1)
	slot2 = StoryModule_pb.GetStoryFinishRequest()
	slot2.storyId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetStoryFinishReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveStoryFinishPush(slot0, slot1, slot2)
	if slot1 == 0 then
		StoryController.instance:setStoryFinished(slot2.storyId)
		StoryController.instance:dispatchEvent(StoryEvent.FinishFromServer, slot2.storyId)
	end
end

slot0.instance = slot0.New()

return slot0
