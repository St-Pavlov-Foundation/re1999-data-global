module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPvpSettleViewContainer", package.seeall)

local var_0_0 = class("AutoChessPvpSettleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessPvpSettleView.New())

	return var_1_0
end

return var_0_0
