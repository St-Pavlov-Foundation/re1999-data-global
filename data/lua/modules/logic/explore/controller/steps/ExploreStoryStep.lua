module("modules.logic.explore.controller.steps.ExploreStoryStep", package.seeall)

slot0 = class("ExploreStoryStep", ExploreStepBase)

function slot0.onStart(slot0)
	StoryController.instance:playStory(slot0._data.storyId, nil, slot0.onDone, slot0)
end

return slot0
