module("modules.logic.survival.view.survivalsimplelistcomp.SurvivalSimpleListItem", package.seeall)

local var_0_0 = class("SurvivalSimpleListItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.viewContainer = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.showItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.data = arg_5_1
	arg_5_0.index = arg_5_2
	arg_5_0.isSelect = arg_5_3

	arg_5_0:onItemShow(arg_5_1)
end

function var_0_0.hideItem(arg_6_0)
	arg_6_0:onItemHide()
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	arg_7_0.isSelect = arg_7_1

	arg_7_0:onSelectChange(arg_7_1)
end

function var_0_0.onItemShow(arg_8_0, arg_8_1)
	return
end

function var_0_0.onItemHide(arg_9_0)
	return
end

function var_0_0.onSelectChange(arg_10_0, arg_10_1)
	return
end

return var_0_0
