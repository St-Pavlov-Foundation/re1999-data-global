module("modules.logic.player.view.PlayerClothGuideViewContainer", package.seeall)

local var_0_0 = class("PlayerClothGuideViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PlayerClothGuideView.New())

	return var_1_0
end

return var_0_0
