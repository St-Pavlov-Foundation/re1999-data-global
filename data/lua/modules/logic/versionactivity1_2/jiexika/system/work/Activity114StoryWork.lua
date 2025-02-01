module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114StoryWork", package.seeall)

slot0 = class("Activity114StoryWork", Activity114BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._storyId = slot1
	slot0._storyType = slot2

	uv0.super.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	if not slot0._storyId then
		slot0._storyId = slot1.storyId
		slot1.storyId = nil
	end

	if type(slot0._storyId) == "string" then
		slot0._storyId = tonumber(slot0._storyId)
	end

	if not slot0._storyId or slot0._storyId <= 0 then
		slot0:onDone(true)

		return
	end

	if Activity114Model.instance.waitStoryFinish then
		Activity114Controller.instance:registerCallback(Activity114Event.StoryFinish, slot0.playStory, slot0)
	else
		slot0:playStory()
	end
end

function slot0.playStory(slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, slot0.playStory, slot0)
	StoryController.instance:registerCallback(StoryEvent.AllStepFinished, slot0._onStoryFinish, slot0)
	StoryController.instance:playStory(slot0._storyId)

	slot0.context.storyType = slot0._storyType
end

function slot0.forceEndStory(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, slot0._onStoryFinish, slot0)
	slot0:onDone(true)
end

function slot0._onStoryFinish(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, slot0._onStoryFinish, slot0)

	if Activity114Model.instance:isEnd() then
		slot0:onDone(false)
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, slot0.playStory, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, slot0._onStoryFinish, slot0)
	uv0.super.clearWork(slot0)
end

return slot0
