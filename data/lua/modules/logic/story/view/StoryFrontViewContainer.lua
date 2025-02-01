module("modules.logic.story.view.StoryFrontViewContainer", package.seeall)

slot0 = class("StoryFrontViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryFrontView.New())

	return slot1
end

return slot0
