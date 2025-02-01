module("modules.logic.guide.controller.action.impl.WaitGuideActionStoryFinish", package.seeall)

slot0 = class("WaitGuideActionStoryFinish", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot0._storyId = slot2[1]
	slot0._noCheckFinish = slot2[2] == 1

	if slot0._storyId and not slot0._noCheckFinish and StoryModel.instance:isStoryFinished(slot0._storyId) then
		slot0:onDone(true)
	else
		StoryController.instance:registerCallback(StoryEvent.Finish, slot0._onStoryFinish, slot0)
	end
end

function slot0._onStoryFinish(slot0, slot1)
	if not slot0._storyId or slot0._storyId == slot1 then
		StoryController.instance:unregisterCallback(StoryEvent.Finish, slot0._onStoryFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, slot0._onStoryFinish, slot0)
end

return slot0
