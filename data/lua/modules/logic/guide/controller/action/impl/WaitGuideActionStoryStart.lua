module("modules.logic.guide.controller.action.impl.WaitGuideActionStoryStart", package.seeall)

slot0 = class("WaitGuideActionStoryStart", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	StoryController.instance:registerCallback(StoryEvent.Start, slot0._onStoryStart, slot0)

	slot0._storyId = tostring(slot0.actionParam)
end

function slot0._onStoryStart(slot0, slot1)
	if not slot0._storyId or slot0._storyId == slot1 then
		StoryController.instance:unregisterCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
end

return slot0
