module("modules.logic.handbook.model.EquipFilterModel", package.seeall)

local var_0_0 = class("EquipFilterModel")

var_0_0.ObtainEnum = {
	Get = 1,
	All = 0,
	NotGet = 2
}

function var_0_0.getAllTagList()
	return lua_equip_tag.configList
end

function var_0_0.generateFilterMo(arg_2_0, arg_2_1)
	arg_2_0.filterMoDict = arg_2_0.filterMoDict or {}

	local var_2_0 = EquipFilterMo.New()

	var_2_0:init(arg_2_1)

	arg_2_0.filterMoDict[arg_2_1] = var_2_0

	return var_2_0
end

function var_0_0.getFilterMo(arg_3_0, arg_3_1)
	return arg_3_0.filterMoDict and arg_3_0.filterMoDict[arg_3_1]
end

function var_0_0.clear(arg_4_0, arg_4_1)
	if arg_4_0.filterMoDict then
		arg_4_0.filterMoDict[arg_4_1] = nil
	end
end

function var_0_0.reset(arg_5_0, arg_5_1)
	if arg_5_0.filterMoDict then
		local var_5_0 = arg_5_0.filterMoDict[arg_5_1]

		if var_5_0 then
			var_5_0:init(arg_5_1)
		end
	end
end

function var_0_0.applyMo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.viewName
	local var_6_1 = arg_6_0.filterMoDict[var_6_0]

	if var_6_1.obtainShowType ~= arg_6_1.obtainShowType then
		var_6_1:updateMo(arg_6_1)
		EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, var_6_0)

		return
	end

	if #arg_6_1.selectTagList ~= #var_6_1.selectTagList then
		var_6_1:updateMo(arg_6_1)
		EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, var_6_0)

		return
	else
		local var_6_2 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_1.selectTagList) do
			var_6_2[iter_6_1] = true
		end

		for iter_6_2, iter_6_3 in ipairs(arg_6_1.selectTagList) do
			if not var_6_2[iter_6_3] then
				var_6_1:updateMo(arg_6_1)
				EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, var_6_0)

				return
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
