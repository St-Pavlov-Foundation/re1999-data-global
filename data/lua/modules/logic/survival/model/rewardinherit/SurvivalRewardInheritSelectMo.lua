module("modules.logic.survival.model.rewardinherit.SurvivalRewardInheritSelectMo", package.seeall)

local var_0_0 = pureTable("SurvivalRewardInheritSelectMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.maxAmount = nil
	arg_1_0.selectIdDic = {}
end

function var_0_0.clear(arg_2_0)
	tabletool.clear(arg_2_0.selectIdDic)
end

function var_0_0.replaceSelectIdDic(arg_3_0, arg_3_1)
	tabletool.clear(arg_3_0.selectIdDic)
	LuaUtil.insertDict(arg_3_0.selectIdDic, arg_3_1)
end

function var_0_0.copySelectIdDic(arg_4_0)
	return tabletool.copy(arg_4_0.selectIdDic)
end

function var_0_0.setMaxAmount(arg_5_0, arg_5_1)
	arg_5_0.maxAmount = arg_5_1
end

function var_0_0.isSelect(arg_6_0, arg_6_1)
	return LuaUtil.tableContains(arg_6_0.selectIdDic, arg_6_1)
end

function var_0_0.replaceOne(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.selectIdDic[arg_7_1] = arg_7_2
end

function var_0_0.removeOne(arg_8_0, arg_8_1)
	local var_8_0 = LuaUtil.indexOfElement(arg_8_0.selectIdDic, arg_8_1)

	if var_8_0 > 0 then
		arg_8_0.selectIdDic[var_8_0] = nil
	end
end

function var_0_0.removeOneByPos(arg_9_0, arg_9_1)
	arg_9_0.selectIdDic[arg_9_1] = nil
end

function var_0_0.haveSelect(arg_10_0)
	return #arg_10_0.selectIdDic > 0
end

function var_0_0.getSelect(arg_11_0, arg_11_1)
	return arg_11_0.selectIdDic[arg_11_1]
end

function var_0_0.getSelectCellCfgId(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getSelect(arg_12_1)

	if var_12_0 then
		return SurvivalHandbookModel.instance:getMoById(var_12_0):getCellCfgId()
	end
end

function var_0_0.haveEmpty(arg_13_0)
	for iter_13_0 = 1, arg_13_0.maxAmount do
		if arg_13_0.selectIdDic[iter_13_0] == nil then
			return true, iter_13_0
		end
	end
end

function var_0_0.getLastPos(arg_14_0)
	local var_14_0 = arg_14_0.maxAmount

	for iter_14_0 = 1, arg_14_0.maxAmount do
		if arg_14_0.selectIdDic[iter_14_0] == nil then
			var_14_0 = iter_14_0

			break
		end
	end

	return var_14_0
end

function var_0_0.getSelectList(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0.selectIdDic) do
		local var_15_1 = SurvivalHandbookModel.instance:getMoById(iter_15_1)

		table.insert(var_15_0, var_15_1:getCellCfgId())
	end

	return var_15_0
end

return var_0_0
