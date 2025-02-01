module("modules.logic.rouge.map.work.WaitRougeStoryDoneWork", package.seeall)

slot0 = class("WaitRougeStoryDoneWork", BaseWork)
slot1 = 9.99
slot2 = "starWaitRougeStoryDoneWorktBlock"

function slot0._onStoryStart(slot0, slot1)
	if slot0.storyId ~= slot1 then
		return
	end

	UIBlockHelper.instance:endBlock(uv0)
end

function slot0.ctor(slot0, slot1)
	slot0.storyId = slot1
end

function slot0.onStart(slot0)
	if not slot0.storyId or slot0.storyId == 0 then
		return slot0:onDone(true)
	end

	StoryController.instance:registerCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
	UIBlockHelper.instance:startBlock(uv0, uv1)
	StoryController.instance:playStory(slot0.storyId, nil, slot0.onStoryDone, slot0)
end

function slot0.onStoryDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
end

return slot0
