module("modules.logic.dungeon.view.rolestory.RoleStoryTipViewContainer", package.seeall)

slot0 = class("RoleStoryTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoleStoryTipView.New())

	return slot1
end

return slot0
