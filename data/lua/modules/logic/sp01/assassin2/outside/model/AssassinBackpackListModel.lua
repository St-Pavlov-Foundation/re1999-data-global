module("modules.logic.sp01.assassin2.outside.model.AssassinBackpackListModel", package.seeall)

local var_0_0 = class("AssassinBackpackListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearAll()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearAll(arg_3_0)
	arg_3_0:clear()
	arg_3_0:clearData()
end

function var_0_0.clearData(arg_4_0)
	arg_4_0._selectedItemId = nil
end

function var_0_0.setAssassinBackpackList(arg_5_0)
	arg_5_0:clearAll()

	local var_5_0 = AssassinItemModel.instance:getAssassinItemMoList()

	arg_5_0:setList(var_5_0)
end

local var_0_1 = 1

function var_0_0.selectCell(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getByIndex(arg_6_1)

	if not var_6_0 then
		arg_6_1 = var_0_1
		var_6_0 = arg_6_0:getByIndex(var_0_1)
	end

	var_0_0.super.selectCell(arg_6_0, arg_6_1, arg_6_2)

	arg_6_0._selectedItemId = var_6_0 and var_6_0:getId()
end

function var_0_0.getSelectedItemId(arg_7_0)
	return arg_7_0._selectedItemId
end

var_0_0.instance = var_0_0.New()

return var_0_0
