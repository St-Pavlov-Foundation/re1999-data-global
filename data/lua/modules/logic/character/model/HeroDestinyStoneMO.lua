module("modules.logic.character.model.HeroDestinyStoneMO", package.seeall)

local var_0_0 = class("HeroDestinyStoneMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.rank = 0
	arg_1_0.level = 0
	arg_1_0.curUseStoneId = 0
	arg_1_0.unlockStoneIds = nil
	arg_1_0.stoneMoList = nil
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

function var_0_0.setStoneMo(arg_6_0)
	local var_6_0 = CharacterDestinyConfig.instance:getFacetIdsByHeroId(arg_6_0.heroId)

	if not arg_6_0.stoneMoList then
		arg_6_0.stoneMoList = {}
	end

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_1 = arg_6_0.stoneMoList[iter_6_1]

			if not var_6_1 then
				var_6_1 = DestinyStoneMO.New()

				var_6_1:initMo(iter_6_1)

				arg_6_0.stoneMoList[iter_6_1] = var_6_1
			end

			var_6_1:refresUnlock(LuaUtil.tableContains(arg_6_0.unlockStoneIds, iter_6_1))
			var_6_1:refreshUse(iter_6_1 == arg_6_0.curUseStoneId)
		end
	end
end

function var_0_0.getStoneMo(arg_7_0, arg_7_1)
	return arg_7_0.stoneMoList and arg_7_0.stoneMoList[arg_7_1]
end

function var_0_0.refreshUseStone(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.stoneMoList) do
		iter_8_1:refreshUse(iter_8_0 == arg_8_0.curUseStoneId)
	end
end

function var_0_0.getCurUseStoneCo(arg_9_0)
	if arg_9_0.curUseStoneId ~= 0 then
		return CharacterDestinyConfig.instance:getDestinyFacets(arg_9_0.curUseStoneId, arg_9_0.rank)
	end
end

function var_0_0.getAddAttrValues(arg_10_0)
	return (arg_10_0:getAddAttrValueByLevel(arg_10_0.rank, arg_10_0.level))
end

function var_0_0.getAddAttrValueByLevel(arg_11_0, arg_11_1, arg_11_2)
	return (CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(arg_11_0.heroId, arg_11_1, arg_11_2))
end

function var_0_0.getAddValueByAttrId(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1 = arg_12_1 or arg_12_0:getAddAttrValues()

	local var_12_0 = arg_12_1[arg_12_2]

	if not var_12_0 then
		arg_12_2 = CharacterDestinyEnum.DestinyUpBaseParseAttr[arg_12_2]

		if arg_12_2 then
			return arg_12_1[arg_12_2] or 0
		end
	else
		return var_12_0
	end

	return 0
end

function var_0_0.getRankLevelCount(arg_13_0)
	return arg_13_0.maxLevel[arg_13_0.rank] or 0
end

function var_0_0.getNextDestinySlotCo(arg_14_0)
	return (CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_14_0.heroId, arg_14_0.rank, arg_14_0.level))
end

function var_0_0.getCurStoneNameAndIcon(arg_15_0)
	if arg_15_0.curUseStoneId == 0 then
		return
	end

	return arg_15_0:getStoneMo(arg_15_0.curUseStoneId):getNameAndIcon()
end

function var_0_0.isCanPlayAttrUnlockAnim(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0:isUnlockSlot() then
		return
	end

	if arg_16_2 > arg_16_0.rank then
		return
	end

	local var_16_0 = arg_16_0:getStoneMo(arg_16_1)

	if not var_16_0 then
		return
	end

	if not var_16_0.isUnlock then
		return
	end

	local var_16_1 = "HeroDestinyStoneMO_isCanPlayAttrUnlockAnim_" .. arg_16_0.heroId .. "_" .. arg_16_2 .. "_" .. arg_16_1

	if GameUtil.playerPrefsGetNumberByUserId(var_16_1, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(var_16_1, 1)

		return true
	end
end

function var_0_0._replaceSkill(arg_17_0, arg_17_1)
	if arg_17_1 then
		local var_17_0 = arg_17_0:getCurUseStoneCo()

		if var_17_0 then
			local var_17_1 = var_17_0.exchangeSkills

			if not string.nilorempty(var_17_1) then
				local var_17_2 = GameUtil.splitString2(var_17_1, true)

				for iter_17_0 = 1, #arg_17_1 do
					for iter_17_1, iter_17_2 in ipairs(var_17_2) do
						local var_17_3 = iter_17_2[1]
						local var_17_4 = iter_17_2[2]

						if arg_17_1[iter_17_0] == var_17_3 then
							arg_17_1[iter_17_0] = var_17_4
						end
					end
				end
			end
		end
	end

	return arg_17_1
end

function var_0_0.setRedDot(arg_18_0, arg_18_1)
	arg_18_0.reddot = arg_18_1
end

function var_0_0.getRedDot(arg_19_0)
	return arg_19_0.reddot or 0
end

function var_0_0.setTrial(arg_20_0)
	if arg_20_0.maxLevel and arg_20_0.maxRank then
		arg_20_0.level = arg_20_0.maxLevel[arg_20_0.maxRank] or 1
	end
end

return var_0_0
