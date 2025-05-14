module("modules.logic.critter.model.CritterFilterModel", package.seeall)

local var_0_0 = class("CritterFilterModel")

function var_0_0.generateFilterMO(arg_1_0, arg_1_1)
	arg_1_0.filterMODict = arg_1_0.filterMODict or {}

	local var_1_0 = CritterFilterMO.New()

	var_1_0:init(arg_1_1)

	arg_1_0.filterMODict[arg_1_1] = var_1_0

	return var_1_0
end

function var_0_0.getFilterMO(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.filterMODict and arg_2_0.filterMODict[arg_2_1]

	if not var_2_0 and arg_2_1 and arg_2_2 then
		var_2_0 = arg_2_0:generateFilterMO(arg_2_1)
	end

	return var_2_0
end

function var_0_0.clear(arg_3_0, arg_3_1)
	if arg_3_0.filterMODict then
		arg_3_0.filterMODict[arg_3_1] = nil
	end
end

function var_0_0.reset(arg_4_0, arg_4_1)
	if arg_4_0.filterMODict then
		local var_4_0 = arg_4_0.filterMODict[arg_4_1]

		if var_4_0 then
			var_4_0:init(arg_4_1)
		end
	end
end

function var_0_0.applyMO(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.viewName
	local var_5_1 = arg_5_0.filterMODict[var_5_0]

	if not var_5_1 then
		arg_5_0.filterMODict[var_5_0] = arg_5_1

		CritterController.instance:dispatchEvent(CritterEvent.CritterChangeFilterType, var_5_0)

		return
	end

	local var_5_2 = var_5_1:getFilterCategoryDict()
	local var_5_3 = arg_5_1:getFilterCategoryDict()

	if not arg_5_0:isSameFilterDict(var_5_2, var_5_3) then
		var_5_1:updateMo(arg_5_1)
		CritterController.instance:dispatchEvent(CritterEvent.CritterChangeFilterType, var_5_0)
	end
end

function var_0_0.isSameFilterDict(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = type(arg_6_1)

	if var_6_0 ~= type(arg_6_2) then
		return false
	end

	if var_6_0 ~= "table" then
		return arg_6_1 == arg_6_2
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_1 = arg_6_2[iter_6_0]

		if var_6_1 == nil or not arg_6_0:isSameFilterDict(iter_6_1, var_6_1) then
			return false
		end
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_2) do
		local var_6_2 = arg_6_1[iter_6_2]

		if var_6_2 == nil or not arg_6_0:isSameFilterDict(var_6_2, iter_6_3) then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
