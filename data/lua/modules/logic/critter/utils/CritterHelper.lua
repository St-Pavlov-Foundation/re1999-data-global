module("modules.logic.critter.utils.CritterHelper", package.seeall)

local var_0_0 = {
	getInitClassMOList = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = {}

		if arg_1_0 then
			for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
				local var_1_1

				if arg_1_2 then
					var_1_1 = arg_1_2[iter_1_0]
				end

				var_1_1 = var_1_1 or arg_1_1.New()

				var_1_1:init(iter_1_1)
				table.insert(var_1_0, var_1_1)
			end
		end

		return var_1_0
	end,
	sortByCritterId = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0:getDefineId()
		local var_2_1 = arg_2_1:getDefineId()

		if var_2_0 ~= var_2_1 then
			return var_2_0 < var_2_1
		end

		return arg_2_0:getId() < arg_2_1:getId()
	end
}

function var_0_0.sortByRareDescend(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getDefineCfg()
	local var_3_1 = arg_3_1:getDefineCfg()
	local var_3_2 = var_3_0.rare
	local var_3_3 = var_3_1.rare

	if var_3_2 ~= var_3_3 then
		return var_3_3 < var_3_2
	end

	return var_0_0.sortByCritterId(arg_3_0, arg_3_1)
end

function var_0_0.sortByRareAscend(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getDefineCfg()
	local var_4_1 = arg_4_1:getDefineCfg()
	local var_4_2 = var_4_0.rare
	local var_4_3 = var_4_1.rare

	if var_4_2 ~= var_4_3 then
		return var_4_2 < var_4_3
	end

	return var_0_0.sortByCritterId(arg_4_0, arg_4_1)
end

function var_0_0.getCritterAttrSortFunc(arg_5_0, arg_5_1)
	if not var_0_0._descendFuncMap then
		var_0_0._descendFuncMap = {
			[CritterEnum.AttributeType.Efficiency] = var_0_0.sortByEfficiencyDescend,
			[CritterEnum.AttributeType.Patience] = var_0_0.sortByPatienceDescend,
			[CritterEnum.AttributeType.Lucky] = var_0_0.sortByLuckyDescend
		}
		var_0_0._ascendSortFuncMap = {
			[CritterEnum.AttributeType.Efficiency] = var_0_0.sortByEfficiencyAscend,
			[CritterEnum.AttributeType.Patience] = var_0_0.sortByPatienceAscend,
			[CritterEnum.AttributeType.Lucky] = var_0_0.sortByLuckyAscend
		}
	end

	return (arg_5_1 and var_0_0._ascendSortFuncMap or var_0_0._descendFuncMap)[arg_5_0]
end

function var_0_0.sortByTotalAttrValue(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getTotalAttrValue()
	local var_6_1 = arg_6_1:getTotalAttrValue()

	if var_6_0 ~= var_6_1 then
		return var_6_1 < var_6_0
	end

	return var_0_0.sortByRareDescend(arg_6_0, arg_6_1)
end

function var_0_0.sortByEfficiencyDescend(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.efficiencyIncrRate
	local var_7_1 = arg_7_1.efficiencyIncrRate

	if var_7_0 ~= var_7_1 then
		return var_7_1 < var_7_0
	end

	local var_7_2 = arg_7_0:isAddition(CritterEnum.AttributeType.Efficiency)

	if var_7_2 ~= arg_7_1:isAddition(CritterEnum.AttributeType.Efficiency) then
		return var_7_2
	end

	if arg_7_0.efficiency ~= arg_7_1.efficiency then
		return arg_7_0.efficiency > arg_7_1.efficiency
	end

	return var_0_0.sortByTotalAttrValue(arg_7_0, arg_7_1)
end

function var_0_0.sortByEfficiencyAscend(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.efficiencyIncrRate
	local var_8_1 = arg_8_1.efficiencyIncrRate

	if var_8_0 ~= var_8_1 then
		return var_8_0 < var_8_1
	end

	local var_8_2 = arg_8_0:isAddition(CritterEnum.AttributeType.Efficiency)

	if var_8_2 ~= arg_8_1:isAddition(CritterEnum.AttributeType.Efficiency) then
		return var_8_2
	end

	if arg_8_0.efficiency ~= arg_8_1.efficiency then
		return arg_8_0.efficiency < arg_8_1.efficiency
	end

	return var_0_0.sortByTotalAttrValue(arg_8_0, arg_8_1)
end

function var_0_0.sortByPatienceDescend(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.patienceIncrRate
	local var_9_1 = arg_9_1.patienceIncrRate

	if var_9_0 ~= var_9_1 then
		return var_9_1 < var_9_0
	end

	local var_9_2 = arg_9_0:isAddition(CritterEnum.AttributeType.Patience)

	if var_9_2 ~= arg_9_1:isAddition(CritterEnum.AttributeType.Patience) then
		return var_9_2
	end

	if arg_9_0.patience ~= arg_9_1.patience then
		return arg_9_0.patience > arg_9_1.patience
	end

	return var_0_0.sortByTotalAttrValue(arg_9_0, arg_9_1)
end

function var_0_0.sortByPatienceAscend(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.patienceIncrRate
	local var_10_1 = arg_10_1.patienceIncrRate

	if var_10_0 ~= var_10_1 then
		return var_10_0 < var_10_1
	end

	local var_10_2 = arg_10_0:isAddition(CritterEnum.AttributeType.Patience)

	if var_10_2 ~= arg_10_1:isAddition(CritterEnum.AttributeType.Patience) then
		return var_10_2
	end

	if arg_10_0.patience ~= arg_10_1.patience then
		return arg_10_0.patience < arg_10_1.patience
	end

	return var_0_0.sortByTotalAttrValue(arg_10_0, arg_10_1)
end

function var_0_0.sortByLuckyDescend(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.luckyIncrRate
	local var_11_1 = arg_11_1.luckyIncrRate

	if var_11_0 ~= var_11_1 then
		return var_11_1 < var_11_0
	end

	local var_11_2 = arg_11_0:isAddition(CritterEnum.AttributeType.Lucky)

	if var_11_2 ~= arg_11_1:isAddition(CritterEnum.AttributeType.Lucky) then
		return var_11_2
	end

	if arg_11_0.lucky ~= arg_11_1.lucky then
		return arg_11_0.lucky > arg_11_1.lucky
	end

	return var_0_0.sortByRareDescend(arg_11_0, arg_11_1)
end

function var_0_0.sortByLuckyAscend(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.luckyIncrRate
	local var_12_1 = arg_12_1.luckyIncrRate

	if var_12_0 ~= var_12_1 then
		return var_12_0 < var_12_1
	end

	local var_12_2 = arg_12_0:isAddition(CritterEnum.AttributeType.Lucky)

	if var_12_2 ~= arg_12_1:isAddition(CritterEnum.AttributeType.Lucky) then
		return var_12_2
	end

	if arg_12_0.lucky ~= arg_12_1.lucky then
		return arg_12_0.lucky < arg_12_1.lucky
	end

	return var_0_0.sortByRareDescend(arg_12_0, arg_12_1)
end

function var_0_0.sortEvent(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0._getEventSortIndex(arg_13_0)
	local var_13_1 = var_0_0._getEventSortIndex(arg_13_1)

	if var_13_0 ~= var_13_1 then
		return var_13_0 < var_13_1
	end
end

function var_0_0._getEventSortIndex(arg_14_0)
	if arg_14_0:isNoMood() then
		return 1
	elseif arg_14_0:isCultivating() then
		if arg_14_0.trainInfo:isHasEventTrigger() then
			return 2
		elseif arg_14_0.trainInfo:isTrainFinish() then
			return 3
		end
	end

	return 100
end

function var_0_0.getEventTypeByCritterMO(arg_15_0)
	if not arg_15_0 then
		return nil
	end

	if arg_15_0:isCultivating() then
		if arg_15_0.trainInfo:isHasEventTrigger() then
			return CritterEnum.CritterItemEventType.HasTrainEvent
		elseif arg_15_0.trainInfo:isTrainFinish() then
			return CritterEnum.CritterItemEventType.TrainEventComplete
		end
	elseif arg_15_0:isNoMoodWorking() then
		return CritterEnum.CritterItemEventType.NoMoodWork
	end

	return nil
end

function var_0_0.getWorkCritterMOListByBuid(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = CritterModel.instance:getAllCritters()

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if iter_16_1:isMaturity() and iter_16_1.workInfo and iter_16_1.workInfo.workBuildingUid == arg_16_0 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

var_0_0._sumTempAttrInfoParam = {}

function var_0_0.sumArrtInfoMOByAttrId(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = var_0_0._sumTempAttrInfoParam

	var_17_0.attributeId = arg_17_0
	var_17_0.value = 0
	var_17_0.rate = 0
	var_17_0.addRate = 0

	if arg_17_1 and #arg_17_1 > 0 then
		for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
			local var_17_1 = iter_17_1:getAttributeInfoByType(arg_17_0, arg_17_2, arg_17_3)

			if var_17_1 then
				var_17_0.value = var_17_0.value + var_17_1.value
				var_17_0.rate = var_17_0.rate + var_17_1.rate
				var_17_0.addRate = var_17_0.addRate + var_17_1:getAdditionRate()
			end
		end
	end

	local var_17_2 = CritterAttributeInfoMO.New()

	var_17_2:init(var_17_0)

	return var_17_2
end

function var_0_0.getPreViewAttrValue(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = ManufactureCritterListModel.instance:getPreviewAttrInfo(arg_18_1, arg_18_2, arg_18_3)

	if var_18_0 then
		if arg_18_0 == CritterEnum.AttributeType.Efficiency then
			return var_18_0.efficiency or 0
		elseif arg_18_0 == CritterEnum.AttributeType.Patience then
			return var_18_0.moodCostSpeed or 0
		elseif arg_18_0 == CritterEnum.AttributeType.Lucky then
			return var_18_0.criRate or 0
		elseif arg_18_0 == CritterEnum.AttributeType.MoodRestore then
			return var_18_0.moodCostSpeed or 0
		end
	end

	return 0
end

function var_0_0.sumPreViewAttrValue(arg_19_0, arg_19_1)
	local var_19_0 = 0

	if arg_19_1 and #arg_19_1 > 0 then
		for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
			var_19_0 = var_19_0 + var_0_0.getPreViewAttrValue(arg_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.formatAttrValue(arg_20_0, arg_20_1)
	if arg_20_0 == CritterEnum.AttributeType.MoodRestore then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_mood_cost_speed"), arg_20_1)
	elseif arg_20_0 == CritterEnum.AttributeType.Patience then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_mood_cost_speed"), arg_20_1)
	elseif arg_20_0 == CritterEnum.AttributeType.Lucky then
		return string.format("%s%%", arg_20_1)
	end

	return arg_20_1
end

function var_0_0.buildFakeCritterMoByConfig(arg_21_0)
	local var_21_0 = CritterMO.New()
	local var_21_1 = 0
	local var_21_2 = 0
	local var_21_3 = 0
	local var_21_4 = 0
	local var_21_5 = 0
	local var_21_6 = 0
	local var_21_7 = {}

	if arg_21_0 then
		if not string.nilorempty(arg_21_0.baseAttribute) then
			local var_21_8 = GameUtil.splitString2(arg_21_0.baseAttribute, true)

			var_21_1 = var_21_8[1][2] or 0
			var_21_2 = var_21_8[2][2] or 0
			var_21_3 = var_21_8[3][2] or 0
		end

		if not string.nilorempty(arg_21_0.baseAttribute) then
			local var_21_9 = GameUtil.splitString2(arg_21_0.attributeIncrRate, true)

			var_21_4 = var_21_9[1][2] or 0
			var_21_5 = var_21_9[2][2] or 0
			var_21_6 = var_21_9[3][2] or 0
		end

		var_21_7 = {
			tags = {
				arg_21_0.raceTag
			}
		}
	end

	local var_21_10 = {
		uid = "0",
		id = "0",
		specialSkin = false,
		defineId = arg_21_0.id,
		efficiency = var_21_1,
		patience = var_21_2,
		lucky = var_21_3,
		efficiencyIncrRate = var_21_4,
		patienceIncrRate = var_21_5,
		luckyIncrRate = var_21_6,
		tagAttributeRates = {},
		skillInfo = var_21_7
	}

	var_21_0:init(var_21_10)

	return var_21_0
end

function var_0_0.getPatienceChangeValue(arg_22_0)
	local var_22_0 = CritterConfig.instance:getPatienceChangeCfg(arg_22_0)

	if var_22_0 then
		return var_22_0.stepTime * var_22_0.stepValue / 3600
	end

	return 0
end

return var_0_0
