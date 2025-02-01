module("modules.logic.dungeon.view.rolestory.RoleStoryFightSuccViewContainer", package.seeall)

slot0 = class("RoleStoryFightSuccViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		RoleStoryFightSuccView.New()
	}
end

return slot0
