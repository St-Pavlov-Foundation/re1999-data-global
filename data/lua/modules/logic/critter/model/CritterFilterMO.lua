module("modules.logic.critter.model.CritterFilterMO", package.seeall)

local var_0_0 = pureTable("CritterFilterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewName = arg_1_1

	arg_1_0:reset()
end

function var_0_0.updateMo(arg_2_0, arg_2_1)
	arg_2_0._isFiltering = false
	arg_2_0.filterCategoryDict = arg_2_1.filterCategoryDict

	for iter_2_0, iter_2_1 in pairs(arg_2_0.filterCategoryDict) do
		if #iter_2_1 > 0 then
			arg_2_0._isFiltering = true
		end
	end
end

function var_0_0.isPassedFilter(arg_3_0, arg_3_1)
	local var_3_0 = false

	if not arg_3_1 then
		return var_3_0
	end

	local var_3_1 = arg_3_1:getDefineId()
	local var_3_2 = arg_3_0:_checkRace(var_3_1)
	local var_3_3 = arg_3_1:getSkillInfo()
	local var_3_4 = arg_3_0:_checkSkill(var_3_3)

	return var_3_2 and var_3_4
end

function var_0_0._checkRace(arg_4_0, arg_4_1)
	local var_4_0 = CritterConfig.instance:getCritterCatalogue(arg_4_1)

	return arg_4_0:checkRaceByCatalogueId(var_4_0)
end

function var_0_0.checkRaceByCatalogueId(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.filterCategoryDict[CritterEnum.FilterType.Race]

	if not var_5_0 or #var_5_0 <= 0 then
		return true
	end

	local var_5_1 = CritterConfig.instance

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1 == arg_5_1 or var_5_1:isHasCatalogueChildId(iter_5_1, arg_5_1) then
			return true
		end
	end

	return false
end

function var_0_0._checkSkill(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.filterCategoryDict[CritterEnum.FilterType.SkillTag]

	if not var_6_0 or #var_6_0 <= 0 then
		return true
	end

	if not arg_6_1 then
		return false
	end

	local var_6_1 = false

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_2 = CritterConfig.instance:getCritterTagCfg(iter_6_1)
		local var_6_3 = string.splitToNumber(var_6_2 and var_6_2.filterTag, "#")

		for iter_6_2, iter_6_3 in ipairs(var_6_3) do
			if tabletool.indexOf(var_6_0, iter_6_3) then
				var_6_1 = true

				break
			end
		end
	end

	return var_6_1
end

function var_0_0.isFiltering(arg_7_0)
	return arg_7_0._isFiltering
end

function var_0_0.isSelectedTag(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = false
	local var_8_1 = arg_8_0.filterCategoryDict[arg_8_1]

	if var_8_1 and #var_8_1 > 0 then
		var_8_0 = tabletool.indexOf(var_8_1, arg_8_2)
	end

	return var_8_0
end

function var_0_0.selectedTag(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.filterCategoryDict[arg_9_1] then
		arg_9_0.filterCategoryDict[arg_9_1] = {}
	end

	table.insert(arg_9_0.filterCategoryDict[arg_9_1], arg_9_2)
end

function var_0_0.unselectedTag(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.filterCategoryDict[arg_10_1] then
		tabletool.removeValue(arg_10_0.filterCategoryDict[arg_10_1], arg_10_2)
	end
end

function var_0_0.getFilterCategoryDict(arg_11_0)
	return arg_11_0.filterCategoryDict
end

function var_0_0.clone(arg_12_0)
	local var_12_0 = var_0_0.New()

	var_12_0:init(arg_12_0.viewName)

	var_12_0.filterCategoryDict = LuaUtil.deepCopySimple(arg_12_0.filterCategoryDict)
	var_12_0._isFiltering = arg_12_0._isFiltering

	return var_12_0
end

function var_0_0.reset(arg_13_0)
	arg_13_0.filterCategoryDict = {}
	arg_13_0._isFiltering = false
end

return var_0_0
