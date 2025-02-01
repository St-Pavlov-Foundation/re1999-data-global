module("modules.logic.story.view.StoryViewContainer", package.seeall)

slot0 = class("StoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryView.New())

	return slot1
end

return slot0
