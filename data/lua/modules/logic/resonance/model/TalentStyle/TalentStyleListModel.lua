module("modules.logic.resonance.model.TalentStyle.TalentStyleListModel", package.seeall)

local var_0_0 = class("TalentStyleListModel", ListScrollModel)

function var_0_0._sort(arg_1_0, arg_1_1)
	if arg_1_0._isUnlock == arg_1_1._isUnlock then
		if arg_1_0._styleId == 0 then
			return false
		end

		if arg_1_1._styleId == 0 then
			return true
		end

		return arg_1_0._styleId < arg_1_1._styleId
	end

	return arg_1_0._isUnlock
end

function var_0_0.initData(arg_2_0, arg_2_1)
	local var_2_0 = TalentStyleModel.instance:getStyleMoList(arg_2_1)

	table.sort(var_2_0, arg_2_0._sort)
	arg_2_0:setList(var_2_0)
end

function var_0_0.refreshData(arg_3_0, arg_3_1)
	local var_3_0 = TalentStyleModel.instance:refreshMoList(arg_3_1, arg_3_0:getList())

	arg_3_0:setList(var_3_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
