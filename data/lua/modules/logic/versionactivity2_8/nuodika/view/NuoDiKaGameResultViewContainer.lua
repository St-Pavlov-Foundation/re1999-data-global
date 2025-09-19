module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameResultViewContainer", package.seeall)

local var_0_0 = class("NuoDiKaGameResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, NuoDiKaGameResultView.New())

	return var_1_0
end

return var_0_0
