module("modules.logic.story.view.StoryBackgroundViewContainer", package.seeall)

slot0 = class("StoryBackgroundViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryBackgroundView.New())

	return slot1
end

return slot0
