module("modules.logic.story.view.StoryBranchViewContainer", package.seeall)

slot0 = class("StoryBranchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryBranchView.New())

	return slot1
end

return slot0
