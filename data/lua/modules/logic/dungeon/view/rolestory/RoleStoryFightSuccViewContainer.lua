module("modules.logic.dungeon.view.rolestory.RoleStoryFightSuccViewContainer", package.seeall)

local var_0_0 = class("RoleStoryFightSuccViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		RoleStoryFightSuccView.New()
	}
end

return var_0_0
