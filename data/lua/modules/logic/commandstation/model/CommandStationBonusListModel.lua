module("modules.logic.commandstation.model.CommandStationBonusListModel", package.seeall)

local var_0_0 = class("CommandStationBonusListModel", MixScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._itemCounts = {}
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._itemCounts = arg_2_2

	arg_2_0:setList(arg_2_1)
end

function var_0_0.getInfoList(arg_3_0, arg_3_1)
	arg_3_0._mixCellInfo = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._itemCounts) do
		local var_3_0 = iter_3_1 * 100 + 70
		local var_3_1 = SLFramework.UGUI.MixCellInfo.New(1, var_3_0, nil)

		table.insert(arg_3_0._mixCellInfo, var_3_1)
	end

	return arg_3_0._mixCellInfo
end

var_0_0.instance = var_0_0.New()

return var_0_0
