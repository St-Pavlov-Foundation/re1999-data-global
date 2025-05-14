module("modules.logic.rouge.controller.RougeSettlementTriggerHelper", package.seeall)

local var_0_0 = class("RougeSettlementTriggerHelper")

function var_0_0.isResultTrigger(arg_1_0, ...)
	local var_1_0 = var_0_0["triggerType" .. arg_1_0]

	if not var_1_0 then
		logError("未处理当前触发类型, 触发类型 = " .. tostring(arg_1_0))

		return
	end

	return var_1_0(...)
end

function var_0_0.triggerType1(arg_2_0)
	local var_2_0 = RougeModel.instance:getRougeResult()
	local var_2_1 = var_2_0 and var_2_0.reviewInfo
	local var_2_2 = var_2_1 and var_2_1.collectionNum or 0

	arg_2_0 = arg_2_0 or 0

	if arg_2_0 <= var_2_2 then
		local var_2_3 = RougeCollectionModel.instance:getCollectionRareMap()
		local var_2_4 = lua_rouge_quality.configList
		local var_2_5 = {}

		if var_2_4 then
			for iter_2_0, iter_2_1 in ipairs(var_2_4) do
				local var_2_6 = iter_2_1.name
				local var_2_7 = iter_2_1.id
				local var_2_8 = var_2_3[var_2_7] and tabletool.len(var_2_3[var_2_7]) or 0

				table.insert(var_2_5, var_2_8)
				table.insert(var_2_5, var_2_6)
			end
		end

		return unpack(var_2_5)
	end
end

function var_0_0.triggerType2(arg_3_0)
	local var_3_0 = RougeCollectionModel.instance:getAllCollections()
	local var_3_1 = {}

	if var_3_0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			var_0_0.computeTagCount(iter_3_1, var_3_1)
		end
	end

	local var_3_2 = 0
	local var_3_3 = -10000

	for iter_3_2, iter_3_3 in pairs(var_3_1) do
		if var_3_3 < iter_3_3 then
			var_3_2 = iter_3_2
			iter_3_3 = var_3_3
		end
	end

	local var_3_4 = lua_rouge_tag.configDict[var_3_2]
	local var_3_5 = var_3_4 and var_3_4.name

	if arg_3_0 <= var_3_3 then
		return var_3_3, var_3_5
	end
end

function var_0_0.computeTagCount(arg_4_0, arg_4_1)
	if not arg_4_0 then
		return 0
	end

	var_0_0.computeTypeTagCount(arg_4_0.cfgId, arg_4_1)

	local var_4_0 = arg_4_0:getAllEnchantCfgId()

	if var_4_0 then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			if iter_4_1 and iter_4_1 > 0 then
				var_0_0.computeTypeTagCount(iter_4_1, arg_4_1)
			end
		end
	end
end

function var_0_0.computeTypeTagCount(arg_5_0, arg_5_1)
	local var_5_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_5_0)
	local var_5_1 = var_5_0 and var_5_0.tags

	if var_5_1 then
		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			arg_5_1[iter_5_1] = (arg_5_1[iter_5_1] or 0) + 1
		end
	end
end

function var_0_0.triggerType3(arg_6_0)
	local var_6_0 = RougeModel.instance:getRougeResult()
	local var_6_1 = var_6_0 and var_6_0.compositeCount or 0
	local var_6_2 = var_6_0:getCompositeCollectionIdAndCount()
	local var_6_3 = {}

	if var_6_2 then
		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			local var_6_4 = iter_6_1[1]
			local var_6_5 = RougeCollectionConfig.instance:getCollectionCfg(var_6_4)
			local var_6_6 = var_6_5 and var_6_5.name

			table.insert(var_6_3, var_6_6)
		end
	end

	if arg_6_0 <= var_6_1 then
		return (table.concat(var_6_3, luaLang("room_levelup_init_and1")))
	end
end

function var_0_0.triggerType4(arg_7_0)
	local var_7_0 = RougeCollectionModel.instance:getSlotAreaCollection()
	local var_7_1 = 0

	if var_7_0 then
		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			local var_7_2 = iter_7_1:getEnchantCount()

			if var_7_2 and var_7_2 > 0 then
				var_7_1 = var_7_1 + 1
			end
		end
	end

	if arg_7_0 <= var_7_1 then
		return var_7_1
	end
end

function var_0_0.triggerType5(arg_8_0)
	local var_8_0 = RougeModel.instance:getRougeResult()
	local var_8_1 = 0

	if var_8_0 then
		var_8_1 = var_8_0:getTotalFightCount()
	end

	if arg_8_0 <= var_8_1 then
		return var_8_1
	end
end

function var_0_0.triggerType6(arg_9_0)
	local var_9_0 = RougeModel.instance:getRougeResult()
	local var_9_1 = var_9_0 and var_9_0.costPower or 0

	if arg_9_0 <= var_9_1 then
		return var_9_1
	end
end

function var_0_0.triggerType7(arg_10_0)
	local var_10_0 = RougeModel.instance:getRougeResult()
	local var_10_1 = var_10_0 and var_10_0.maxDamage or 0

	if arg_10_0 <= var_10_1 then
		return var_10_1
	end
end

function var_0_0.triggerType8(arg_11_0)
	local var_11_0 = RougeModel.instance:getRougeResult()
	local var_11_1 = false

	if var_11_0 then
		var_11_1 = var_11_0:isEventFinish(arg_11_0)
	end

	if var_11_1 then
		local var_11_2 = RougeMapConfig.instance:getRougeEvent(arg_11_0)

		return var_11_2 and var_11_2.name
	end
end

function var_0_0.triggerType9(arg_12_0)
	local var_12_0 = RougeModel.instance:getRougeResult()
	local var_12_1 = false

	if var_12_0 then
		var_12_1 = var_12_0:isEntrustFinish(arg_12_0)
	end

	if var_12_1 then
		return arg_12_0
	end
end

function var_0_0.triggerType10(arg_13_0)
	local var_13_0 = RougeModel.instance:getRougeResult()
	local var_13_1 = var_13_0 and var_13_0.consumeCoin or 0

	if arg_13_0 <= var_13_1 then
		return var_13_1
	end
end

function var_0_0.triggerType11(arg_14_0)
	local var_14_0 = RougeModel.instance:getRougeResult()
	local var_14_1 = var_14_0 and var_14_0.displaceNum or 0

	if arg_14_0 <= var_14_1 then
		return var_14_1
	end
end

function var_0_0.triggerType12(arg_15_0)
	local var_15_0 = RougeModel.instance:getRougeResult()
	local var_15_1 = var_15_0 and var_15_0.repairShopNum or 0

	if arg_15_0 <= var_15_1 then
		return var_15_1
	end
end

function var_0_0.triggerType13(arg_16_0)
	local var_16_0 = RougeModel.instance:getRougeResult()
	local var_16_1 = var_16_0 and var_16_0.reviewInfo
	local var_16_2 = var_16_1 and var_16_1.endId

	if var_16_2 == arg_16_0 then
		return var_16_2
	end
end

function var_0_0.triggerType14(arg_17_0)
	local var_17_0 = RougeMapModel.instance:getEndId()

	if not RougeModel.instance:getRougeResult():isSucceed() and var_17_0 == arg_17_0 then
		return var_17_0
	end
end

function var_0_0.triggerType15()
	if RougeModel.instance:isAbortRouge() then
		return
	end

	local var_18_0 = RougeModel.instance:getRougeResult()
	local var_18_1 = RougeMapModel.instance:getEndId()
	local var_18_2 = not var_18_0:isSucceed() and (not var_18_1 or var_18_1 <= 0)
	local var_18_3 = RougeMapModel.instance:getCurEvent()

	if not var_18_3 then
		return
	end

	local var_18_4 = var_18_3.name

	if var_18_2 then
		return var_18_4
	end
end

function var_0_0.triggerType16()
	if RougeModel.instance:isAbortRouge() then
		return "abort"
	end
end

function var_0_0.triggerType17()
	local var_20_0 = RougeModel.instance:getRougeInfo()
	local var_20_1 = RougeModel.instance:getRougeResult()
	local var_20_2 = var_20_1 and var_20_1.season
	local var_20_3 = lua_rouge_difficulty.configDict[var_20_2][var_20_0.difficulty]
	local var_20_4 = var_20_3 and var_20_3.title
	local var_20_5 = RougeController.instance:getStyleConfig()
	local var_20_6 = var_20_5 and var_20_5.name
	local var_20_7 = var_0_0.getAllInitHeroNames(var_20_1.initHeroId)

	return var_20_4, var_20_6, var_20_7
end

function var_0_0.getAllInitHeroNames(arg_21_0)
	local var_21_0 = {}

	if arg_21_0 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
			local var_21_1 = HeroConfig.instance:getHeroCO(iter_21_1)
			local var_21_2 = var_21_1 and var_21_1.name

			if var_21_2 then
				table.insert(var_21_0, var_21_2)
			end
		end
	end

	return (table.concat(var_21_0, luaLang("room_levelup_init_and1")))
end

function var_0_0.triggerType18()
	local var_22_0 = RougeModel.instance:getRougeResult()
	local var_22_1 = var_22_0 and var_22_0.reviewInfo
	local var_22_2 = var_22_1 and var_22_1:getTeamInfo()
	local var_22_3 = var_22_2 and var_22_2:getAllHeroCount() or 0
	local var_22_4 = RougeModel.instance:getRougeInfo()
	local var_22_5 = var_22_4 and var_22_4.teamSize or 0

	return var_22_3, var_22_5
end

function var_0_0.triggerType19()
	local var_23_0 = RougeModel.instance:getRougeResult()
	local var_23_1 = var_23_0 and var_23_0.reviewInfo
	local var_23_2 = var_23_1 and var_23_1.gainCoin or 0

	return var_23_0 and var_23_0.stepNum, var_23_2
end

function var_0_0.triggerType20()
	local var_24_0 = RougeModel.instance:getRougeInfo()
	local var_24_1 = var_24_0 and var_24_0.teamExp or 0
	local var_24_2 = var_24_0 and var_24_0.teamLevel or 0
	local var_24_3 = var_24_0.season

	return var_0_0._getTotalTeamExp(var_24_3, var_24_2, var_24_1), var_24_2
end

function var_0_0._getTotalTeamExp(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0 then
		return 0
	end

	arg_25_1 = arg_25_1 or 0
	arg_25_2 = arg_25_2 or 0

	local var_25_0 = lua_rouge_level.configDict[arg_25_0]
	local var_25_1 = 0

	for iter_25_0 = 1, arg_25_1 do
		local var_25_2 = var_25_0 and var_25_0[iter_25_0]

		var_25_1 = var_25_1 + (var_25_2 and var_25_2.exp or 0)
	end

	return var_25_1 + arg_25_2
end

return var_0_0
