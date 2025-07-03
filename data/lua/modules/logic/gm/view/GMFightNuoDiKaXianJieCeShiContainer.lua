module("modules.logic.gm.view.GMFightNuoDiKaXianJieCeShiContainer", package.seeall)

local var_0_0 = class("GMFightNuoDiKaXianJieCeShiContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, GMFightNuoDiKaXianJieCeShi.New())

	return var_1_0
end

return var_0_0
