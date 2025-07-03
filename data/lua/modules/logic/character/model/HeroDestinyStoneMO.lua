module("modules.logic.character.model.HeroDestinyStoneMO", package.seeall)

local var_0_0 = class("HeroDestinyStoneMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.rank = 0
	arg_1_0.level = 0
	arg_1_0.curUseStoneId = 0
	arg_1_0.unlockStoneIds = nil
	arg_1_0.stoneMoList = nil
	arg_1_0.upStoneId = nil
	arg_1_0.heroId = arg_1_1
	arg_1_0.maxRank = 0
	arg_1_0.maxLevel = {}

	local var_1_0 = CharacterDestinyConfig.instance:getDestinySlotCosByHeroId(arg_1_1)

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			arg_1_0.maxRank = math.max(iter_1_0, arg_1_0.maxRank)
			arg_1_0.maxLevel[iter_1_0] = tabletool.len(iter_1_1)
		end
	end
end

function var_0_0.refreshMo(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.rank = arg_2_1
	arg_2_0.level = arg_2_2
	arg_2_0.curUseStoneId = arg_2_3
	arg_2_0.unlockStoneIds = arg_2_4 or {}

	arg_2_0:setStoneMo()
end

function var_0_0.isUnlockSlot(arg_3_0)
	return arg_3_0.rank > 0
end

function var_0_0.isCanUpSlotRank(arg_4_0)
	local var_4_0 = arg_4_0:getNextDestinySlotCo()

	return var_4_0 and var_4_0.node == 1
end

function var_0_0.isSlotMaxLevel(arg_5_0)
	return not arg_5_0:getNextDestinySlotCo()
end

function var_0_0.isAllFacetUnlock(arg_6_0)
	if not arg_6_0.stoneMoList then
		return false
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.stoneMoList) do
		if not iter_6_1.isUnlock then
			return false
		end
	end

	return true
end

function var_0_0.setUpStoneId(arg_7_0, arg_7_1)
	arg_7_0.upStoneId = arg_7_1
end

function var_0_0.getUpStoneId(arg_8_0)
	return arg_8_0.upStoneId
end

function var_0_0.clearUpStoneId(arg_9_0)
	arg_9_0.upStoneId = nil
end

function var_0_0.checkAllUnlock(arg_10_0)
	return arg_10_0:isSlotMaxLevel() and arg_10_0:isAllFacetUnlock()
end

function var_0_0.setStoneMo(arg_11_0)
	local var_11_0 = CharacterDestinyConfig.instance:getFacetIdsByHeroId(arg_11_0.heroId)

	if not arg_11_0.stoneMoList then
		arg_11_0.stoneMoList = {}
	end

	if var_11_0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			local var_11_1 = arg_11_0.stoneMoList[iter_11_1]

			if not var_11_1 then
				var_11_1 = DestinyStoneMO.New()

				var_11_1:initMo(iter_11_1)

				arg_11_0.stoneMoList[iter_11_1] = var_11_1
			end

			var_11_1:refresUnlock(LuaUtil.tableContains(arg_11_0.unlockStoneIds, iter_11_1))
			var_11_1:refreshUse(iter_11_1 == arg_11_0.curUseStoneId)
		end
	end
end

function var_0_0.getStoneMoList(arg_12_0)
	return arg_12_0.stoneMoList and arg_12_0.stoneMoList
end

function var_0_0.getStoneMo(arg_13_0, arg_13_1)
	return arg_13_0.stoneMoList and arg_13_0.stoneMoList[arg_13_1]
end

function var_0_0.refreshUseStone(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.stoneMoList) do
		iter_14_1:refreshUse(iter_14_0 == arg_14_0.curUseStoneId)
	end
end

function var_0_0.getCurUseStoneCo(arg_15_0)
	if arg_15_0.curUseStoneId ~= 0 then
		return CharacterDestinyConfig.instance:getDestinyFacets(arg_15_0.curUseStoneId, arg_15_0.rank)
	end
end

function var_0_0.getAddAttrValues(arg_16_0)
	return (arg_16_0:getAddAttrValueByLevel(arg_16_0.rank, arg_16_0.level))
end

function var_0_0.getAddAttrValueByLevel(arg_17_0, arg_17_1, arg_17_2)
	return (CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(arg_17_0.heroId, arg_17_1, arg_17_2))
end

function var_0_0.getAddValueByAttrId(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1 = arg_18_1 or arg_18_0:getAddAttrValues()

	local var_18_0 = arg_18_1[arg_18_2]

	if not var_18_0 then
		local var_18_1 = CharacterDestinyEnum.DestinyUpBaseParseAttr[arg_18_2]

		if var_18_1 then
			local var_18_2 = var_18_1[1]

			if var_18_2 then
				var_18_0 = arg_18_1[var_18_2] or 0
				var_18_0 = var_18_0 + (arg_18_0:getPercentAddValueByAttrId(arg_18_1, arg_18_2, arg_18_3) or 0)

				return var_18_0
			end
		end
	else
		return var_18_0
	end

	return 0
end

function var_0_0.getPercentAddValueByAttrId(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_1 = arg_19_1 or arg_19_0:getAddAttrValues()

	if not arg_19_3 then
		arg_19_3 = HeroModel.instance:getById(arg_19_0.heroId)

		if not arg_19_3 then
			return 0
		end
	end

	local var_19_0 = arg_19_3:getHeroBaseAttrDict()[arg_19_2] or 0
	local var_19_1 = CharacterDestinyEnum.DestinyUpBaseParseAttr[arg_19_2]
	local var_19_2 = var_19_0 * (arg_19_1[var_19_1 and var_19_1[2]] or 0) * 0.01

	return math.floor(var_19_2)
end

function var_0_0.getRankLevelCount(arg_20_0)
	return arg_20_0.maxLevel[arg_20_0.rank] or 0
end

function var_0_0.getNextDestinySlotCo(arg_21_0)
	return (CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_21_0.heroId, arg_21_0.rank, arg_21_0.level))
end

function var_0_0.getCurStoneNameAndIcon(arg_22_0)
	if arg_22_0.curUseStoneId == 0 then
		return
	end

	return arg_22_0:getStoneMo(arg_22_0.curUseStoneId):getNameAndIcon()
end

function var_0_0.isCanPlayAttrUnlockAnim(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0:isUnlockSlot() then
		return
	end

	if arg_23_2 > arg_23_0.rank then
		return
	end

	local var_23_0 = arg_23_0:getStoneMo(arg_23_1)

	if not var_23_0 then
		return
	end

	if not var_23_0.isUnlock then
		return
	end

	local var_23_1 = "HeroDestinyStoneMO_isCanPlayAttrUnlockAnim_" .. arg_23_0.heroId .. "_" .. arg_23_2 .. "_" .. arg_23_1

	if GameUtil.playerPrefsGetNumberByUserId(var_23_1, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(var_23_1, 1)

		return true
	end
end

function var_0_0._replaceSkill(arg_24_0, arg_24_1)
	if arg_24_1 then
		local var_24_0 = arg_24_0:getCurUseStoneCo()

		if var_24_0 then
			local var_24_1 = var_24_0.exchangeSkills

			if not string.nilorempty(var_24_1) then
				local var_24_2 = GameUtil.splitString2(var_24_1, true)

				for iter_24_0 = 1, #arg_24_1 do
					for iter_24_1, iter_24_2 in ipairs(var_24_2) do
						local var_24_3 = iter_24_2[1]
						local var_24_4 = iter_24_2[2]

						if arg_24_1[iter_24_0] == var_24_3 then
							arg_24_1[iter_24_0] = var_24_4
						end
					end
				end
			end
		end
	end

	return arg_24_1
end

function var_0_0.setRedDot(arg_25_0, arg_25_1)
	arg_25_0.reddot = arg_25_1
end

function var_0_0.getRedDot(arg_26_0)
	return arg_26_0.reddot or 0
end

function var_0_0.setTrial(arg_27_0)
	if arg_27_0.maxLevel and arg_27_0.maxRank then
		arg_27_0.level = arg_27_0.maxLevel[arg_27_0.maxRank] or 1
	end
end

return var_0_0
