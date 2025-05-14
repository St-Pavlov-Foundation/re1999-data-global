module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipViewContainer", package.seeall)

local var_0_0 = class("YaXianGameTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, YaXianGameTipView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

return var_0_0
