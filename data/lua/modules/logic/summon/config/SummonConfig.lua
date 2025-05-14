module("modules.logic.summon.config.SummonConfig", package.seeall)

local var_0_0 = class("SummonConfig", BaseConfig)

function var_0_0.getDurationByPoolType(arg_1_0, arg_1_1)
	if arg_1_1 == SummonEnum.Type.NewPlayer then
		return (CommonConfig.instance:getConstNum(ConstEnum.SummonPoolNewPlayerDuration) or 0) * 86400
	end

	return 0
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"summon_pool",
		"summon",
		"summon_character",
		"summon_pool_detail",
		"summon_equip_detail",
		"lucky_bag_heroes"
	}
end

function var_0_0.onInit(arg_3_0)
	return
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "summon_equip_detail" then
		arg_4_0:_initEquipDetails()
	end
end

function var_0_0._initEquipDetails(arg_5_0)
	arg_5_0._equipPoolDict = {}

	local var_5_0 = lua_summon_equip_detail.configList

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		arg_5_0._equipPoolDict[iter_5_1.poolId] = arg_5_0._equipPoolDict[iter_5_1.poolId] or {}
		arg_5_0._equipPoolDict[iter_5_1.poolId][iter_5_1.location] = iter_5_1
	end
end

function var_0_0.getSummonPoolList(arg_6_0)
	return lua_summon_pool.configList
end

function var_0_0.getSummon(arg_7_0, arg_7_1)
	return lua_summon.configDict[arg_7_1]
end

function var_0_0.getCharacterDetailConfig(arg_8_0, arg_8_1)
	return lua_summon_character.configDict[arg_8_1]
end

function var_0_0.getPoolDetailConfig(arg_9_0, arg_9_1)
	return lua_summon_pool_detail.configDict[arg_9_1]
end

function var_0_0.getPoolDetailConfigList(arg_10_0)
	return lua_summon_pool_detail.configList
end

function var_0_0.getEquipDetailByPoolId(arg_11_0, arg_11_1)
	return arg_11_0._equipPoolDict[arg_11_1]
end

function var_0_0.getSummonPool(arg_12_0, arg_12_1)
	return lua_summon_pool.configDict[arg_12_1]
end

function var_0_0.getSummonLuckyBag(arg_13_0, arg_13_1)
	if not arg_13_0._pool2luckyBagMap then
		arg_13_0._pool2luckyBagMap = {}
	end

	local var_13_0 = arg_13_0._pool2luckyBagMap[arg_13_1]

	if not var_13_0 then
		var_13_0 = var_13_0 or {}

		local var_13_1 = var_0_0.instance:getSummon(arg_13_1)

		if var_13_1 then
			for iter_13_0, iter_13_1 in pairs(var_13_1) do
				if not string.nilorempty(iter_13_1.luckyBagId) then
					tabletool.addValues(var_13_0, string.splitToNumber(iter_13_1.luckyBagId, "#"))
				end
			end
		end

		arg_13_0._pool2luckyBagMap[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.getLuckyBag(arg_14_0, arg_14_1, arg_14_2)
	if lua_lucky_bag_heroes.configDict[arg_14_1] then
		return lua_lucky_bag_heroes.configDict[arg_14_1][arg_14_2]
	end
end

function var_0_0.getLuckyBagHeroIds(arg_15_0, arg_15_1, arg_15_2)
	if VersionValidator.instance:isInReviewing() then
		if #lua_app_include.configList > 0 then
			return lua_app_include.configList[1].character
		else
			return {}
		end
	end

	if not arg_15_0._luckyBagHerosMap then
		arg_15_0._luckyBagHerosMap = {}
	end

	if not arg_15_0._luckyBagHerosMap[arg_15_1] then
		arg_15_0._luckyBagHerosMap[arg_15_1] = {}
	end

	local var_15_0 = arg_15_0._luckyBagHerosMap[arg_15_1][arg_15_2]

	if not var_15_0 then
		local var_15_1 = arg_15_0:getLuckyBag(arg_15_1, arg_15_2)

		if var_15_1 then
			var_15_0 = string.splitToNumber(var_15_1.heroChoices, "#")
		else
			logError("summon luckyBag config not found, id = " .. tostring(arg_15_2))

			var_15_0 = {}
		end

		arg_15_0._luckyBagHerosMap[arg_15_1][arg_15_2] = var_15_0
	end

	return var_15_0
end

function var_0_0.getValidPoolList(arg_16_0)
	local var_16_0 = arg_16_0:getSummonPoolList()
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not string.nilorempty(iter_16_1.customClz) and not string.nilorempty(iter_16_1.prefabPath) then
			table.insert(var_16_1, iter_16_1)
		end
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		if arg_17_0.priority == arg_17_1.priority then
			return arg_17_0.id < arg_17_1.id
		end

		return arg_17_0.priority > arg_17_1.priority
	end)

	return var_16_1
end

function var_0_0.getSummonSSRTimes(arg_18_0)
	if arg_18_0 then
		var_0_0.instance.ssrTimesMap = var_0_0.instance.ssrTimesMap or {}

		local var_18_0 = var_0_0.instance.ssrTimesMap[arg_18_0.id]

		if not var_18_0 then
			local var_18_1 = string.split(arg_18_0.awardTime, "|")

			if #var_18_1 >= 2 then
				var_18_0 = tonumber(var_18_1[2])
				var_0_0.instance.ssrTimesMap[arg_18_0.id] = var_18_0
			end
		end

		return var_18_0
	end

	return nil
end

function var_0_0.getRewardItems(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = {}
	local var_19_1
	local var_19_2 = HeroConfig.instance:getHeroCO(arg_19_1)

	if arg_19_2 <= 0 then
		var_19_1 = var_19_2.firstItem

		if arg_19_3 then
			local var_19_3 = {
				type = MaterialEnum.MaterialType.Hero,
				id = arg_19_1
			}

			var_19_3.quantity = 1

			table.insert(var_19_0, var_19_3)
		end
	elseif arg_19_2 < CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount) - 1 then
		var_19_1 = var_19_2.duplicateItem
	else
		var_19_1 = var_19_2.duplicateItem2
	end

	if not string.nilorempty(var_19_1) then
		local var_19_4 = string.split(var_19_1, "|")

		for iter_19_0, iter_19_1 in ipairs(var_19_4) do
			local var_19_5 = {}
			local var_19_6 = string.split(iter_19_1, "#")

			var_19_5.type = tonumber(var_19_6[1])
			var_19_5.id = tonumber(var_19_6[2])
			var_19_5.quantity = tonumber(var_19_6[3])

			table.insert(var_19_0, var_19_5)
		end
	end

	return var_19_0
end

function var_0_0.canShowSingleFree(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getSummonPool(arg_20_1)

	return var_20_0 ~= nil and var_20_0.totalFreeCount ~= nil and var_20_0.totalFreeCount > 0
end

function var_0_0.isLuckyBagPoolExist(arg_21_0)
	local var_21_0 = arg_21_0:getSummonPoolList()

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if iter_21_1.type == SummonEnum.Type.LuckyBag then
			return true
		end
	end

	return false
end

function var_0_0.poolIsLuckyBag(arg_22_0)
	local var_22_0 = var_0_0.instance:getSummonPool(arg_22_0)

	if var_22_0 then
		return var_0_0.poolTypeIsLuckyBag(var_22_0.type)
	end

	return false
end

function var_0_0.poolTypeIsLuckyBag(arg_23_0)
	return arg_23_0 == SummonEnum.Type.LuckyBag
end

function var_0_0.getSummonDetailIdByHeroId(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(lua_summon_character.configList) do
		if iter_24_1.heroId == arg_24_1 then
			return iter_24_1.id
		end
	end
end

function var_0_0.isStrongCustomChoice(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0.instance:getSummonPool(arg_25_1)

	if var_25_0 then
		return var_25_0.type == SummonEnum.Type.StrongCustomOnePick
	end

	return false
end

function var_0_0.getStrongCustomChoiceIds(arg_26_0, arg_26_1)
	local var_26_0 = var_0_0.instance:getSummonPool(arg_26_1)

	if var_26_0 and var_26_0.type == SummonEnum.Type.StrongCustomOnePick then
		return string.splitToNumber(var_26_0.param, "#")
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
