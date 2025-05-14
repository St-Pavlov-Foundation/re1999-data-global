module("modules.logic.player.view.PlayerChangeBgListViewContainer", package.seeall)

local var_0_0 = class("PlayerChangeBgListViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		PlayerChangeBgListView.New()
	}
end

return var_0_0
