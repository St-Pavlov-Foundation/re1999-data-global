module("modules.logic.guide.controller.action.impl.GuideActionPlayStory", package.seeall)

slot0 = class("GuideActionPlayStory", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._storyId = tonumber(slot3) or nil

	if slot0._storyId == nil then
		slot0._storyIds = string.splitToNumber(slot3, "#")
	end
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0._storyId then
		if StoryModel.instance:isPrologueSkip(slot0._storyId) then
			StoryController.instance:setStoryFinished(slot0._storyId)
			StoryRpc.instance:sendUpdateStoryRequest(slot0._storyId, -1, 0)
			StoryController.instance:dispatchEvent(StoryEvent.Finish, slot0._storyId)
		else
			StoryController.instance:playStory(slot0._storyId, {
				mark = true
			})
		end

		slot0:onDone(true)
	elseif slot0._storyIds and #slot0._storyIds > 0 then
		StoryController.instance:playStories(slot0._storyIds, {
			mark = true
		})
		slot0:onDone(true)
	else
		logError("Guide story id nil, guide_" .. slot0.guideId .. "_" .. slot0.stepId)
		slot0:onDone(false)
	end
end

return slot0
