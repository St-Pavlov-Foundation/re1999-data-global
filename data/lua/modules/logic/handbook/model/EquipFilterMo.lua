module("modules.logic.handbook.model.EquipFilterMo", package.seeall)

local var_0_0 = pureTable("EquipFilterMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewName = arg_1_1

	arg_1_0:reset()
end

function var_0_0.reset(arg_2_0)
	arg_2_0.obtainShowType = EquipFilterModel.ObtainEnum.All
	arg_2_0.selectTagList = {}
	arg_2_0.filtering = false
end

function var_0_0.getObtainType(arg_3_0)
	return arg_3_0.obtainShowType
end

function var_0_0.checkIsIncludeTag(arg_4_0, arg_4_1)
	if arg_4_0.selectTagList and not next(arg_4_0.selectTagList) then
		return true
	end

	local var_4_0 = EquipConfig.instance:getTagList(arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if tabletool.indexOf(arg_4_0.selectTagList, iter_4_1) then
			return true
		end
	end

	return false
end

function var_0_0.updateIsFiltering(arg_5_0)
	arg_5_0.filtering = arg_5_0.obtainShowType ~= EquipFilterModel.ObtainEnum.All or arg_5_0.selectTagList and next(arg_5_0.selectTagList)
end

function var_0_0.updateMo(arg_6_0, arg_6_1)
	arg_6_0.obtainShowType = arg_6_1.obtainShowType
	arg_6_0.selectTagList = arg_6_1.selectTagList

	arg_6_0:updateIsFiltering()
end

function var_0_0.isFiltering(arg_7_0)
	return arg_7_0.filtering
end

function var_0_0.clone(arg_8_0)
	local var_8_0 = var_0_0.New()

	var_8_0:init(arg_8_0.viewName)

	var_8_0.obtainShowType = arg_8_0.obtainShowType
	var_8_0.selectTagList = tabletool.copy(arg_8_0.selectTagList)
	var_8_0.filtering = arg_8_0.filtering

	return var_8_0
end

return var_0_0
