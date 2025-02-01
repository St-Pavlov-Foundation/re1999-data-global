module("modules.logic.story.view.StoryTyperViewContainer", package.seeall)

slot0 = class("StoryTyperViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryTyperView.New())

	return slot1
end

return slot0
