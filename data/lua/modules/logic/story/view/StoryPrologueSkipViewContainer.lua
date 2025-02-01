module("modules.logic.story.view.StoryPrologueSkipViewContainer", package.seeall)

slot0 = class("StoryPrologueSkipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryPrologueSkipView.New())

	return slot1
end

return slot0
