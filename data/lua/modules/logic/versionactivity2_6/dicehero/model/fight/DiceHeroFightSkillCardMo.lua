module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightSkillCardMo", package.seeall)

local var_0_0 = pureTable("DiceHeroFightSkillCardMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.curSelectUids = arg_1_0.curSelectUids or {}
	arg_1_0.skillId = arg_1_1.skillId
	arg_1_0.curRoundUse = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.roundUseCounts) do
		if iter_1_1.round == arg_1_2 then
			arg_1_0.curRoundUse = iter_1_1.count

			break
		end
	end

	arg_1_0.co = lua_dice_card.configDict[arg_1_0.skillId]

	if not arg_1_0.co then
		logError("dice_card配置不存在" .. arg_1_0.skillId)
	end

	arg_1_0.matchDiceUids = {}

	if arg_1_0.matchNums then
		return
	end

	arg_1_0.matchNums = {}
	arg_1_0.matchDiceRules = {}

	local var_1_0 = string.splitToNumber(arg_1_0.co.patternlist, "#") or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		local var_1_1 = lua_dice_pattern.configDict[iter_1_3]

		if not var_1_1 then
			logError("dice_pattern配置不存在" .. iter_1_3)
		end

		local var_1_2 = GameUtil.splitString2(var_1_1.patternList, true) or {}

		arg_1_0.matchNums[iter_1_2] = (arg_1_0.matchNums[iter_1_2 - 1] or 0) + #var_1_2

		for iter_1_4, iter_1_5 in ipairs(var_1_2) do
			table.insert(arg_1_0.matchDiceRules, iter_1_5)
		end
	end
end

function var_0_0.initMatchDices(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.curSelectUids = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.matchDiceRules) do
		local var_2_0 = iter_2_1[1]
		local var_2_1 = iter_2_1[2]
		local var_2_2 = DiceHeroConfig.instance:getDiceSuitDict(var_2_0)
		local var_2_3 = DiceHeroConfig.instance:getDicePointDict(var_2_1)

		if not var_2_2 then
			logError("dice_suit配置不存在" .. var_2_0)
		end

		if not var_2_3 then
			logError("dice_point配置不存在" .. var_2_1)
		end

		local var_2_4 = {}

		for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
			if arg_2_0:isMatchDice(iter_2_3, var_2_2, var_2_3, arg_2_2) then
				table.insert(var_2_4, iter_2_3.uid)
			end
		end

		arg_2_0.matchDiceUids[iter_2_0] = var_2_4
	end
end

function var_0_0.isMatchDice(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_1.deleted or arg_3_1.status == DiceHeroEnum.DiceStatu.HardLock then
		return false
	end

	if not arg_3_3[arg_3_1.num] then
		return false
	end

	local var_3_0 = DiceHeroConfig.instance:getDiceSuitDict(arg_3_1.suitId)

	for iter_3_0 in pairs(var_3_0) do
		if arg_3_2[iter_3_0] then
			return true
		end

		if arg_3_4 and iter_3_0 == DiceHeroEnum.DiceType.Power then
			return true
		end
	end

	return false
end

function var_0_0.isMatchMin(arg_4_0, arg_4_1)
	if #arg_4_0.matchNums == 0 or #arg_4_0.matchDiceUids == 0 then
		return true, {}
	end

	local var_4_0 = arg_4_0.matchNums[1]
	local var_4_1 = {}
	local var_4_2 = {}
	local var_4_3 = {}

	for iter_4_0 = 1, var_4_0 do
		local var_4_4 = #arg_4_0.matchDiceUids[iter_4_0]

		if var_4_4 == 0 then
			return false
		end

		var_4_2[iter_4_0] = var_4_4
		var_4_1[iter_4_0] = 1
	end

	local var_4_5 = {}

	while var_4_1[1] <= var_4_2[1] do
		for iter_4_1 = 1, var_4_0 do
			var_4_3[iter_4_1] = arg_4_0.matchDiceUids[iter_4_1][var_4_1[iter_4_1]]
		end

		for iter_4_2 = var_4_0, 1, -1 do
			var_4_1[iter_4_2] = var_4_1[iter_4_2] + 1

			if var_4_1[iter_4_2] > var_4_2[iter_4_2] and iter_4_2 ~= 1 then
				var_4_1[iter_4_2] = 1
			else
				break
			end
		end

		if not arg_4_0:isRepeat(var_4_3) then
			if arg_4_1 then
				table.insert(var_4_5, var_4_3)

				var_4_3 = {}
			else
				return true, var_4_3
			end
		end
	end

	if var_4_5[1] then
		if var_4_5[2] then
			local var_4_6 = DiceHeroFightModel.instance:getGameData().diceBox.dicesByUid

			if arg_4_0.skillId == 19 then
				local var_4_7 = 1
				local var_4_8 = math.huge

				for iter_4_3, iter_4_4 in ipairs(var_4_5) do
					local var_4_9 = 0

					for iter_4_5, iter_4_6 in ipairs(iter_4_4) do
						var_4_9 = var_4_9 + var_4_6[iter_4_6].num
					end

					if var_4_9 < var_4_8 then
						var_4_7 = iter_4_3
						var_4_8 = var_4_9
					end
				end

				return true, var_4_5[var_4_7]
			end

			local var_4_10 = 1
			local var_4_11 = -1
			local var_4_12 = 0

			for iter_4_7, iter_4_8 in ipairs(var_4_5) do
				local var_4_13 = 0
				local var_4_14 = 0

				for iter_4_9, iter_4_10 in ipairs(iter_4_8) do
					local var_4_15 = arg_4_0.matchDiceRules[iter_4_9][1]
					local var_4_16 = var_4_6[iter_4_10].suitId

					if DiceHeroEnum.BaseDiceSuitDict[var_4_15] and DiceHeroEnum.BaseDiceSuitDict[var_4_16] then
						var_4_13 = var_4_13 + 1
					end

					var_4_14 = var_4_14 + var_4_6[iter_4_10].num
				end

				if var_4_11 < var_4_13 or var_4_13 == var_4_11 and var_4_12 < var_4_14 then
					var_4_10 = iter_4_7
					var_4_11 = var_4_13
					var_4_12 = var_4_14
				end
			end

			return true, var_4_5[var_4_10]
		else
			return true, var_4_5[1]
		end
	end

	return false
end

function var_0_0.isRepeat(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_1 - 1 do
		for iter_5_1 = iter_5_0 + 1, #arg_5_1 do
			if arg_5_1[iter_5_0] == arg_5_1[iter_5_1] then
				return true
			end
		end
	end

	return false
end

function var_0_0.canSelect(arg_6_0)
	if DiceHeroFightModel.instance:getGameData().allyHero:isBanSkillCard(arg_6_0.co.type) then
		return false, DiceHeroEnum.CantUseReason.BanSkill
	end

	if arg_6_0.co.roundLimitCount ~= 0 and arg_6_0.curRoundUse >= arg_6_0.co.roundLimitCount then
		return false, DiceHeroEnum.CantUseReason.NoUseCount
	end

	if not arg_6_0:isMatchMin() then
		return false, DiceHeroEnum.CantUseReason.NoDice
	end

	return true
end

function var_0_0.addDice(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.matchDiceUids do
		if not arg_7_0.curSelectUids[iter_7_0] and tabletool.indexOf(arg_7_0.matchDiceUids[iter_7_0], arg_7_1) then
			arg_7_0.curSelectUids[iter_7_0] = arg_7_1

			DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardDiceChange)

			return true
		end
	end

	return false
end

function var_0_0.getCanUseDiceUidDict(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, #arg_8_0.matchDiceUids do
		if not arg_8_0.curSelectUids[iter_8_0] then
			for iter_8_1, iter_8_2 in pairs(arg_8_0.matchDiceUids[iter_8_0]) do
				var_8_0[iter_8_2] = true
			end
		end
	end

	return var_8_0
end

function var_0_0.removeDice(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_0.matchDiceUids do
		if arg_9_0.curSelectUids[iter_9_0] == arg_9_1 then
			arg_9_0.curSelectUids[iter_9_0] = nil

			arg_9_0:_refreshDiceIndex()
			DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardDiceChange)

			break
		end
	end
end

function var_0_0._refreshDiceIndex(arg_10_0)
	local var_10_0 = #arg_10_0.matchDiceUids

	repeat
		local var_10_1 = false

		for iter_10_0 = var_10_0, 1, -1 do
			if arg_10_0.curSelectUids[iter_10_0] then
				for iter_10_1 = 1, iter_10_0 - 1 do
					if not arg_10_0.curSelectUids[iter_10_1] and tabletool.indexOf(arg_10_0.matchDiceUids[iter_10_1], arg_10_0.curSelectUids[iter_10_0]) then
						arg_10_0.curSelectUids[iter_10_0], arg_10_0.curSelectUids[iter_10_1] = arg_10_0.curSelectUids[iter_10_1], arg_10_0.curSelectUids[iter_10_0]
						var_10_1 = true

						break
					end
				end
			end
		end
	until not var_10_1
end

function var_0_0.clearSelects(arg_11_0)
	arg_11_0.curSelectUids = {}
end

function var_0_0.canUse(arg_12_0)
	if #arg_12_0.matchNums == 0 then
		return -1, {}
	end

	local var_12_0 = 0

	for iter_12_0 = 1, #arg_12_0.matchDiceUids do
		if not arg_12_0.curSelectUids[iter_12_0] then
			break
		end

		var_12_0 = iter_12_0
	end

	for iter_12_1 = #arg_12_0.matchNums, 1, -1 do
		if var_12_0 >= arg_12_0.matchNums[iter_12_1] then
			return iter_12_1, {
				unpack(arg_12_0.curSelectUids, 1, arg_12_0.matchNums[iter_12_1])
			}
		end
	end

	return false
end

function var_0_0.clearMatches(arg_13_0)
	arg_13_0.matchDiceUids = {}
end

return var_0_0
