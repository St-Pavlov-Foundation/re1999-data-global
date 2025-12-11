module("modules.logic.summon.model.SummonModel", package.seeall)

local var_0_0 = class("SummonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._summonResult = nil
	arg_1_0._orderedSummonResult = nil
	arg_1_0._duplicateCountList = nil
	arg_1_0._freeEquipSummon = nil
	arg_1_0._isEquipSendFree = nil

	arg_1_0:setIsDrawing(false)
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._summonResult = nil
	arg_2_0._orderedSummonResult = nil
	arg_2_0._duplicateCountList = nil
	arg_2_0._freeEquipSummon = nil
	arg_2_0._isEquipSendFree = nil

	arg_2_0:setIsDrawing(false)
end

function var_0_0.updateSummonResult(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._summonResult = {}
	arg_3_0._orderedSummonResult = {}
	arg_3_0._duplicateCountList = {}

	if arg_3_1 and #arg_3_1 > 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_0 = SummonResultMO.New()

			var_3_0:init(iter_3_1)

			if iter_3_1.heroId and iter_3_1.heroId ~= 0 then
				arg_3_0._duplicateCountList[iter_3_1.heroId] = arg_3_0._duplicateCountList[iter_3_1.heroId] or {}

				table.insert(arg_3_0._duplicateCountList[iter_3_1.heroId], iter_3_1.duplicateCount or 0)
			end

			table.insert(arg_3_0._summonResult, var_3_0)
		end

		local var_3_1 = {
			1,
			10,
			2,
			9,
			3,
			8,
			4,
			7,
			5,
			6
		}
		local var_3_2 = {}

		for iter_3_2 = 1, #arg_3_0._summonResult do
			table.insert(var_3_2, arg_3_0._summonResult[iter_3_2])
		end

		var_0_0.sortResult(var_3_2, arg_3_2)

		arg_3_0._orderedSummonResult = {}

		for iter_3_3 = 1, #var_3_2 do
			arg_3_0._orderedSummonResult[var_3_1[iter_3_3]] = var_3_2[iter_3_3]
		end
	end
end

function var_0_0.sortResult(arg_4_0, arg_4_1)
	if SummonConfig.poolIsLuckyBag(arg_4_1) then
		table.sort(arg_4_0, var_0_0.sortResultLuckyBag)
	else
		table.sort(arg_4_0, var_0_0.sortResultByRare)
	end
end

function var_0_0.sortResultByRare(arg_5_0, arg_5_1)
	if arg_5_0.heroId ~= 0 and arg_5_1.heroId ~= 0 then
		local var_5_0 = HeroConfig.instance:getHeroCO(arg_5_0.heroId)
		local var_5_1 = HeroConfig.instance:getHeroCO(arg_5_1.heroId)

		if var_5_0.rare ~= var_5_1.rare then
			return var_5_0.rare > var_5_1.rare
		else
			return var_5_0.id > var_5_1.id
		end
	else
		local var_5_2 = EquipConfig.instance:getEquipCo(arg_5_0.equipId)
		local var_5_3 = EquipConfig.instance:getEquipCo(arg_5_1.equipId)

		if var_5_2.rare ~= var_5_3.rare then
			return var_5_2.rare > var_5_3.rare
		else
			return var_5_2.id > var_5_3.id
		end
	end
end

function var_0_0.sortHeroIsResultByRare(arg_6_0, arg_6_1)
	if arg_6_0 ~= 0 and arg_6_1 ~= 0 then
		local var_6_0 = HeroConfig.instance:getHeroCO(arg_6_0)
		local var_6_1 = HeroConfig.instance:getHeroCO(arg_6_1)

		if var_6_0.rare ~= var_6_1.rare then
			return var_6_0.rare > var_6_1.rare
		else
			return var_6_0.id > var_6_1.id
		end
	else
		local var_6_2 = EquipConfig.instance:getEquipCo(arg_6_0)
		local var_6_3 = EquipConfig.instance:getEquipCo(arg_6_1)

		if var_6_2.rare ~= var_6_3.rare then
			return var_6_2.rare > var_6_3.rare
		else
			return var_6_2.id > var_6_3.id
		end
	end
end

function var_0_0.sortResultByHeroIds(arg_7_0)
	local var_7_0 = {
		1,
		10,
		2,
		9,
		3,
		8,
		4,
		7,
		5,
		6
	}
	local var_7_1 = {}

	for iter_7_0 = 1, #arg_7_0 do
		table.insert(var_7_1, arg_7_0[iter_7_0])
	end

	table.sort(arg_7_0, var_0_0.sortHeroIsResultByRare)

	arg_7_0 = {}

	for iter_7_1 = 1, #var_7_1 do
		arg_7_0[var_7_0[iter_7_1]] = var_7_1[iter_7_1]
	end
end

function var_0_0.sortResultLuckyBag(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:isLuckyBag()

	if var_8_0 ~= arg_8_1:isLuckyBag() then
		return var_8_0
	elseif var_8_0 then
		return arg_8_0.luckyBagId < arg_8_1.luckyBagId
	else
		return var_0_0.sortResultByRare(arg_8_0, arg_8_1)
	end
end

function var_0_0.getSummonResult(arg_9_0, arg_9_1)
	if arg_9_1 then
		return arg_9_0._orderedSummonResult
	else
		return arg_9_0._summonResult
	end
end

function var_0_0.openSummonResult(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getSummonResult(true)

	if var_10_0 and var_10_0[arg_10_1] and not var_10_0[arg_10_1]:isOpened() then
		local var_10_1 = var_10_0[arg_10_1]

		var_10_1:setOpen()

		local var_10_2 = -1
		local var_10_3 = 0

		if not var_10_1:isLuckyBag() then
			local var_10_4 = arg_10_0._duplicateCountList[var_10_1.heroId] or {}

			for iter_10_0 = 1, #var_10_4 do
				if var_10_2 > var_10_4[iter_10_0] or var_10_2 < 0 then
					var_10_2 = var_10_4[iter_10_0]
					var_10_3 = iter_10_0
				end
			end

			if var_10_3 > 0 then
				table.remove(var_10_4, var_10_3)
			end
		end

		return var_10_1, var_10_2
	end
end

function var_0_0.openSummonEquipResult(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getSummonResult(true)

	if var_11_0 and var_11_0[arg_11_1] and not var_11_0[arg_11_1]:isOpened() then
		local var_11_1 = var_11_0[arg_11_1]

		var_11_1:setOpen()

		return var_11_1, var_11_1.isNew
	end
end

function var_0_0.isAllOpened(arg_12_0)
	if not arg_12_0._summonResult or #arg_12_0._summonResult <= 0 then
		return true
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._summonResult) do
		if not iter_12_1:isOpened() then
			return false
		end
	end

	return true
end

function var_0_0.setFreeEquipSummon(arg_13_0, arg_13_1)
	arg_13_0._freeEquipSummon = arg_13_1
end

function var_0_0.getFreeEquipSummon(arg_14_0)
	return arg_14_0._freeEquipSummon
end

function var_0_0.setSendEquipFreeSummon(arg_15_0, arg_15_1)
	arg_15_0._isEquipSendFree = arg_15_1
end

function var_0_0.getSendEquipFreeSummon(arg_16_0)
	return arg_16_0._isEquipSendFree
end

function var_0_0.getBestRare(arg_17_0)
	local var_17_0 = 2

	if not arg_17_0 then
		return var_17_0
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0) do
		local var_17_1 = 2

		if iter_17_1.heroId and iter_17_1.heroId ~= 0 then
			var_17_1 = HeroConfig.instance:getHeroCO(iter_17_1.heroId).rare
		elseif iter_17_1.equipId and iter_17_1.equipId ~= 0 then
			var_17_1 = EquipConfig.instance:getEquipCo(iter_17_1.equipId).rare
		elseif iter_17_1.luckyBagId and iter_17_1.luckyBagId ~= 0 then
			var_17_1 = SummonEnum.LuckyBagRare
		end

		var_17_0 = math.max(var_17_0, var_17_1)
	end

	return var_17_0
end

function var_0_0.getRewardList(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0 = 1, #arg_18_0 do
		local var_18_2 = arg_18_0[iter_18_0]
		local var_18_3

		if var_18_2.heroId ~= 0 then
			var_18_3 = SummonConfig.instance:getRewardItems(var_18_2.heroId, var_18_2.duplicateCount, arg_18_1)
		else
			var_18_3 = var_0_0.getEquipRewardItem(var_18_2)
		end

		for iter_18_1 = 1, #var_18_3 do
			local var_18_4 = var_18_3[iter_18_1]

			var_18_1[var_18_4.type] = var_18_1[var_18_4.type] or {}
			var_18_1[var_18_4.type][var_18_4.id] = (var_18_1[var_18_4.type][var_18_4.id] or 0) + var_18_4.quantity
		end
	end

	for iter_18_2, iter_18_3 in pairs(var_18_1) do
		for iter_18_4, iter_18_5 in pairs(iter_18_3) do
			local var_18_5 = MaterialDataMO.New()

			var_18_5:initValue(iter_18_2, iter_18_4, iter_18_5)

			var_18_5.config = ItemModel.instance:getItemConfig(iter_18_2, iter_18_4)

			table.insert(var_18_0, var_18_5)
		end
	end

	return var_18_0
end

function var_0_0.appendRewardTicket(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = #arg_19_0

	if var_19_0 > 0 then
		local var_19_1 = MaterialDataMO.New()

		var_19_1:initValue(MaterialEnum.MaterialType.Item, arg_19_2, var_19_0)

		var_19_1.config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, arg_19_2)

		table.insert(arg_19_1, var_19_1)
	end
end

function var_0_0.getEquipRewardItem(arg_20_0)
	local var_20_0 = {}

	if arg_20_0.returnMaterials then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0.returnMaterials) do
			table.insert(var_20_0, {
				type = iter_20_1.materilType,
				id = iter_20_1.materilId,
				quantity = iter_20_1.quantity
			})
		end
	end

	return var_20_0
end

function var_0_0.sortRewards(arg_21_0, arg_21_1)
	local var_21_0

	if arg_21_0.config.rare == arg_21_1.config.rare then
		return nil
	else
		var_21_0 = arg_21_0.config.rare > arg_21_1.config.rare
	end

	if var_21_0 ~= nil then
		return var_21_0
	end

	local var_21_1 = (arg_21_0.materilType ~= arg_21_1.materilType or nil) and arg_21_0.materilType > arg_21_1.materilType

	if var_21_1 ~= nil then
		return var_21_1
	end

	return (arg_21_0.materilId ~= arg_21_1.materilId or nil) and arg_21_0.materilId > arg_21_1.materilId
end

function var_0_0.formatRemainTime(arg_22_0)
	if arg_22_0 <= 0 then
		return string.format(luaLang("summonmain_deadline_time_min"), 0, 0)
	end

	arg_22_0 = math.floor(arg_22_0)

	local var_22_0 = math.floor(arg_22_0 / 86400)
	local var_22_1 = math.floor(arg_22_0 % 86400 / 3600)
	local var_22_2 = math.floor(arg_22_0 % 3600 / 60)

	if var_22_0 > 0 then
		local var_22_3 = {
			var_22_0,
			var_22_1,
			var_22_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time_day"), var_22_3)
	elseif var_22_1 < 1 and var_22_2 < 1 then
		return luaLang("summonmain_deadline_time_min")
	else
		local var_22_4 = {
			var_22_1,
			var_22_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), var_22_4)
	end
end

function var_0_0.setIsDrawing(arg_23_0, arg_23_1)
	arg_23_0._isDrawing = arg_23_1
end

function var_0_0.getIsDrawing(arg_24_0)
	return arg_24_0._isDrawing
end

function var_0_0.getSummonFullExSkillHero(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = SummonConfig.instance:getSummonPool(arg_25_1)
	local var_25_1 = {}

	if var_25_0 and not string.nilorempty(var_25_0.upWeight) then
		local var_25_2 = string.split(var_25_0.upWeight, "|")

		table.insert(var_25_1, tonumber(var_25_2[1]))
	end

	if arg_25_2 ~= nil and #arg_25_2 > 0 then
		var_25_1 = arg_25_2
	end

	for iter_25_0 = 1, #var_25_1 do
		local var_25_3 = var_25_1[iter_25_0]
		local var_25_4 = 0
		local var_25_5 = HeroModel.instance:getByHeroId(var_25_3)

		if var_25_5 then
			var_25_4 = var_25_5.exSkillLevel

			if var_25_4 >= 5 then
				return var_25_3
			end
		end

		local var_25_6 = SkillConfig.instance:getheroexskillco(var_25_3)

		if var_25_6 then
			local var_25_7 = 0
			local var_25_8
			local var_25_9

			for iter_25_1 = 1, #var_25_6 do
				if var_25_4 < iter_25_1 then
					local var_25_10 = var_25_6[iter_25_1]

					if var_25_10 then
						local var_25_11 = string.splitToNumber(var_25_10.consume, "#")

						var_25_9 = var_25_11[1]
						var_25_8 = var_25_11[2]
						var_25_7 = var_25_11[3] + var_25_7
					end
				end
			end

			if var_25_8 and var_25_9 and var_25_7 <= ItemModel.instance:getItemQuantity(var_25_9, var_25_8) then
				return var_25_3
			end
		end
	end

	return nil
end

function var_0_0.cacheReward(arg_26_0, arg_26_1)
	if arg_26_0._cacheReward == nil then
		arg_26_0._cacheReward = {}
	end

	if arg_26_1 ~= nil then
		tabletool.addValues(arg_26_0._cacheReward, arg_26_1)
	end
end

function var_0_0.getCacheReward(arg_27_0)
	return arg_27_0._cacheReward
end

function var_0_0.clearCacheReward(arg_28_0)
	if arg_28_0._cacheReward then
		tabletool.clear(arg_28_0._cacheReward)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
