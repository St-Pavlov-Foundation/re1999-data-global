module("modules.logic.gm.view.GMFightNuoDiKaXianJieAnNiuContainer", package.seeall)

local var_0_0 = class("GMFightNuoDiKaXianJieAnNiuContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, GMFightNuoDiKaXianJieAnNiu.New())

	return var_1_0
end

return var_0_0
