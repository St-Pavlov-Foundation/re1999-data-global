module("modules.logic.versionactivity2_5.autochess.view.AutoChessStartFightViewContainer", package.seeall)

local var_0_0 = class("AutoChessStartFightViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessStartFightView.New())

	return var_1_0
end

return var_0_0
