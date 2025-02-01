module("modules.logic.story.view.StoryLeadRoleSpineViewContainer", package.seeall)

slot0 = class("StoryLeadRoleSpineViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryLeadRoleSpineView.New())

	return slot1
end

return slot0
