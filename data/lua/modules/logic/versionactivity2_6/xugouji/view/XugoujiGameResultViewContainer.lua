module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameResultViewContainer", package.seeall)

local var_0_0 = class("XugoujiGameResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._resultView = XugoujiGameResultView.New()

	table.insert(var_1_0, arg_1_0._resultView)

	return var_1_0
end

return var_0_0
