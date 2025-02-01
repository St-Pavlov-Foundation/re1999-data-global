module("modules.logic.dungeon.view.rolestory.RoleStoryReviewViewContainer", package.seeall)

slot0 = class("RoleStoryReviewViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoleStoryReviewView.New())

	return slot1
end

return slot0
