module("modules.logic.gm.model.GMAddItemModel", package.seeall)

local var_0_0 = class("GMAddItemModel", ListScrollModel)

function var_0_0.setFastAddHeroView(arg_1_0, arg_1_1)
	arg_1_0.fastAddHeroView = arg_1_1
end

function var_0_0.onOnClickItem(arg_2_0, arg_2_1)
	if arg_2_0.fastAddHeroView then
		arg_2_0.fastAddHeroView:onAddItemOnClick(arg_2_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
