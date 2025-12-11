module("modules.logic.survival.model.rewardinherit.SurvivalRewardInheritModel", package.seeall)

local var_0_0 = class("SurvivalRewardInheritModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.amplifierSelectMo = SurvivalRewardInheritSelectMo.New()

	arg_1_0.amplifierSelectMo:setMaxAmount(1)

	arg_1_0.npcSelectMo = SurvivalRewardInheritSelectMo.New()

	arg_1_0.npcSelectMo:setMaxAmount(3)

	arg_1_0.selectMo = SurvivalPosSelectMo.New()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
end

function var_0_0.isNeedHandbookSelect(arg_4_0)
	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_4_0 and var_4_0.day ~= 1 then
		return true
	end

	return false
end

function var_0_0.getExtendScore(arg_5_0)
	return SurvivalShelterModel.instance:getWeekInfo().extendScore
end

function var_0_0.getInheritHandBookDatas(arg_6_0, arg_6_1, arg_6_2)
	return SurvivalHandbookModel.instance:getInheritHandBookDatas(arg_6_1, arg_6_2)
end

function var_0_0.getInheritId(arg_7_0, arg_7_1)
	return arg_7_1:getCellCfgId()
end

function var_0_0.getInheritMoByInheritIdId(arg_8_0, arg_8_1)
	return SurvivalHandbookModel.instance:getInheritMoById(arg_8_1)
end

function var_0_0.getCurExtendScore(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.selectMo.dataList) do
		var_9_0 = var_9_0 + arg_9_0:getInheritMoByInheritIdId(iter_9_1):getSurvivalBagItemMo():getExtendCost()
	end

	return var_9_0
end

function var_0_0.getSelectMo(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.selectMo.dataList) do
		local var_10_1 = arg_10_0:getInheritMoByInheritIdId(iter_10_1)

		table.insert(var_10_0, var_10_1)
	end

	return var_10_0
end

function var_0_0.getSelectNum(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.selectMo.dataList
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = arg_11_0:getInheritMoByInheritIdId(iter_11_1)

		if var_11_2:getType() == arg_11_1 and (arg_11_2 == nil or var_11_2:getSubType() == arg_11_2) then
			var_11_1 = var_11_1 + 1
		end
	end

	return var_11_1
end

function var_0_0.getChooseList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = arg_12_0.selectMo.dataList

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_3 = arg_12_0:getInheritMoByInheritIdId(iter_12_1)

		if var_12_3:getType() == SurvivalEnum.HandBookType.Amplifier then
			table.insert(var_12_0, var_12_3:getCellCfgId())
		elseif var_12_3:getType() == SurvivalEnum.HandBookType.Npc then
			table.insert(var_12_1, var_12_3:getCellCfgId())
		end
	end

	return var_12_0, var_12_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
