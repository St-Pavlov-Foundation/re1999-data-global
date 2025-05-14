module("modules.logic.versionactivity2_2.lopera.view.LoperaGameResultViewContainer", package.seeall)

local var_0_0 = class("LoperaGameResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._resultView = LoperaGameResultView.New()

	table.insert(var_1_0, arg_1_0._resultView)

	return var_1_0
end

return var_0_0
