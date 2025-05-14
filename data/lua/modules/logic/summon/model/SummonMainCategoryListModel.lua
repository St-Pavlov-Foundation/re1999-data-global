module("modules.logic.summon.model.SummonMainCategoryListModel", package.seeall)

local var_0_0 = class("SummonMainCategoryListModel", ListScrollModel)

function var_0_0.initCategory(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = SummonMainModel.getValidPools()

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = arg_1_0:createMO(iter_1_1, iter_1_0)

		table.insert(var_1_0, var_1_2)
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.createMO(arg_2_0, arg_2_1, arg_2_2)
	return {
		originConf = arg_2_1,
		index = arg_2_2
	}
end

function var_0_0.saveEnterTime(arg_3_0)
	arg_3_0._enterTime = Time.realtimeSinceStartup
end

function var_0_0.canPlayEnterAnim(arg_4_0)
	if Time.realtimeSinceStartup - arg_4_0._enterTime < 0.334 then
		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
