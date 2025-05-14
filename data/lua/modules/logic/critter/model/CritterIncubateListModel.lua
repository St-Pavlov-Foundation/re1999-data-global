module("modules.logic.critter.model.CritterIncubateListModel", package.seeall)

local var_0_0 = class("CritterIncubateListModel", ListScrollModel)

function var_0_0.setMoList(arg_1_0, arg_1_1)
	arg_1_0.moList = arg_1_0:getMoList(arg_1_1)

	arg_1_0:sortMoList(arg_1_1)

	return #arg_1_0.moList
end

function var_0_0.sortMoList(arg_2_0, arg_2_1)
	if not arg_2_0.moList then
		arg_2_0.moList = arg_2_0:getMoList(arg_2_1)
	end

	local var_2_0 = CritterIncubateModel.instance:getSortType()
	local var_2_1 = CritterIncubateModel.instance:getSortWay()
	local var_2_2

	if var_2_0 == CritterEnum.AttributeType.Efficiency then
		var_2_2 = var_2_1 and CritterHelper.sortByEfficiencyDescend or CritterHelper.sortByEfficiencyAscend
	elseif var_2_0 == CritterEnum.AttributeType.Patience then
		var_2_2 = var_2_1 and CritterHelper.sortByPatienceDescend or CritterHelper.sortByPatienceAscend
	elseif var_2_0 == CritterEnum.AttributeType.Lucky then
		var_2_2 = var_2_1 and CritterHelper.sortByLuckyDescend or CritterHelper.sortByLuckyAscend
	end

	if var_2_2 then
		table.sort(arg_2_0.moList, var_2_2)
	end

	arg_2_0:setList(arg_2_0.moList)
end

function var_0_0.getMoList(arg_3_0, arg_3_1)
	local var_3_0 = CritterModel.instance:getCanIncubateCritters()
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = true

		if arg_3_1 and arg_3_1:isPassedFilter(iter_3_1) then
			table.insert(var_3_1, iter_3_1)
		end
	end

	return var_3_1
end

function var_0_0.getMoIndex(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getList()

	return tabletool.indexOf(var_4_0, arg_4_1), #var_4_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
