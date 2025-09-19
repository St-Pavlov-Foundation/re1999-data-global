module("modules.logic.versionactivity2_8.molideer.helper.MoLiDeErHelper", package.seeall)

local var_0_0 = {}

var_0_0.OptionConditionDic = {
	[MoLiDeErEnum.OptionConditionType.Team] = var_0_0.checkTeamValid,
	[MoLiDeErEnum.OptionConditionType.Item] = var_0_0.checkItemValid
}

function var_0_0.isTeamBuffed(arg_1_0, arg_1_1)
	local var_1_0 = MoLiDeErConfig.instance:getTeamConfig(arg_1_1)

	if var_1_0 == nil then
		return false
	end

	local var_1_1 = MoLiDeErConfig.instance:getOptionCondition(arg_1_0, MoLiDeErEnum.OptionConditionType.Team)

	if var_1_1 ~= nil then
		return var_1_1[arg_1_1] ~= nil
	end

	local var_1_2 = MoLiDeErConfig.instance:getOptionConfig(arg_1_0)

	if not string.nilorempty(var_1_2.effect) then
		local var_1_3 = tonumber(var_1_0.buffId)

		if var_1_3 == nil or var_1_3 == 0 then
			return false
		end

		local var_1_4 = MoLiDeErConfig.instance:getBuffConfig(var_1_3)

		if string.nilorempty(var_1_4.effectDesc) then
			return false
		end

		local var_1_5 = string.splitToNumber(var_1_4.effectType, "#")
		local var_1_6 = var_1_5[1]
		local var_1_7 = var_1_5[2]
		local var_1_8 = string.split(var_1_2.effect, "|")

		for iter_1_0, iter_1_1 in ipairs(var_1_8) do
			local var_1_9 = string.splitToNumber(iter_1_1, "#")
			local var_1_10 = var_1_9[1]
			local var_1_11 = var_1_9[#var_1_9]

			if var_1_10 == MoLiDeErEnum.OptionEffectType.Round and var_1_11 > 0 and (var_1_6 == MoLiDeErEnum.RoundBuffType.Fixed or var_1_6 == MoLiDeErEnum.RoundBuffType.Percent) and var_1_7 < 0 then
				return true
			elseif var_1_10 == MoLiDeErEnum.OptionEffectType.Execution and var_1_11 < 0 and (var_1_6 == MoLiDeErEnum.ExecutionBuffType.Fixed or var_1_6 == MoLiDeErEnum.ExecutionBuffType.Percent) and var_1_7 < 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isTeamEnable(arg_2_0, arg_2_1)
	local var_2_0 = MoLiDeErConfig.instance:getOptionCondition(arg_2_0, MoLiDeErEnum.OptionConditionType.Team)

	if var_2_0 == nil then
		return true
	end

	return var_2_0[arg_2_1] ~= nil
end

function var_0_0.handleImage(arg_3_0)
	local var_3_0 = arg_3_0.imgTransform
	local var_3_1 = arg_3_0.offsetParam

	ZProj.UGUIHelper.SetImageSize(var_3_0.gameObject)

	if string.nilorempty(var_3_1) then
		return
	end

	local var_3_2 = string.splitToNumber(var_3_1, "#")
	local var_3_3 = var_3_2[1] or 1
	local var_3_4 = var_3_2[2] or 1
	local var_3_5 = var_3_2[3] or 0
	local var_3_6 = var_3_2[4] or 0

	transformhelper.setLocalScale(var_3_0, var_3_3, var_3_4, 1)
	recthelper.setAnchor(var_3_0, var_3_5, var_3_6)
end

function var_0_0.getExecutionCostStr(arg_4_0)
	local var_4_0 = ""

	if arg_4_0 ~= 0 then
		if arg_4_0 > 0 then
			var_4_0 = string.format("+%s", math.abs(arg_4_0))
		else
			var_4_0 = string.format("-%s", math.abs(arg_4_0))
		end
	end

	return var_4_0
end

function var_0_0.getGameRoundTitleDesc(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0 <= 9 and "0" .. tostring(arg_5_0) or tostring(arg_5_0)

	if arg_5_1 ~= nil then
		local var_5_1 = arg_5_1 <= 9 and "0" .. tostring(arg_5_1) or tostring(arg_5_1)

		var_5_0 = string.format("%s/%s", var_5_0, var_5_1)
	end

	return var_5_0
end

function var_0_0.getOptionRestrictionParamList(arg_6_0)
	local var_6_0 = MoLiDeErConfig.instance:getOptionConfig(arg_6_0)
	local var_6_1 = {}

	if not string.nilorempty(var_6_0.optionRestriction) then
		local var_6_2 = string.splitToNumber(var_6_0.optionRestriction, "#")
		local var_6_3 = var_6_2[1]

		if var_6_3 == MoLiDeErEnum.OptionRestrictionType.Team then
			for iter_6_0 = 2, #var_6_2 do
				local var_6_4 = MoLiDeErConfig.instance:getTeamConfig(var_6_2[iter_6_0])

				table.insert(var_6_1, var_6_4.name)
			end
		elseif var_6_3 == MoLiDeErEnum.OptionRestrictionType.Item then
			for iter_6_1 = 2, #var_6_2 do
				local var_6_5 = MoLiDeErConfig.instance:getItemConfig(var_6_2[iter_6_1])

				table.insert(var_6_1, var_6_5.name)
			end
		end
	end

	return var_6_1
end

function var_0_0.getOptionEffectParamList(arg_7_0, arg_7_1)
	local var_7_0 = MoLiDeErConfig.instance:getOptionConfig(arg_7_0)
	local var_7_1 = {}

	if not string.nilorempty(var_7_0.effect) then
		local var_7_2 = string.split(var_7_0.effect, "|")

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			local var_7_3 = string.splitToNumber(iter_7_1, "#")
			local var_7_4 = var_7_3[1]
			local var_7_5 = var_7_3[#var_7_3]

			if var_7_4 == MoLiDeErEnum.OptionEffectType.Round then
				local var_7_6 = MoLiDeErGameModel.instance:getRoundCost(var_7_5, arg_7_1)

				table.insert(var_7_1, tostring(var_7_6))
			elseif var_7_4 == MoLiDeErEnum.OptionEffectType.Execution then
				local var_7_7 = MoLiDeErGameModel.instance:getExecutionCost(var_7_5, arg_7_1)

				table.insert(var_7_1, var_0_0.getExecutionCostStr(var_7_7))
			elseif var_7_4 == MoLiDeErEnum.OptionEffectType.Team then
				local var_7_8 = MoLiDeErConfig.instance:getTeamConfig(var_7_3[#var_7_3])

				table.insert(var_7_1, var_7_8.name)
			elseif var_7_4 == MoLiDeErEnum.OptionEffectType.Item then
				local var_7_9 = MoLiDeErConfig.instance:getItemConfig(var_7_3[#var_7_3])

				table.insert(var_7_1, var_7_9.name)
			end
		end
	end

	return var_7_1
end

function var_0_0.getOptionResultEffectParamList(arg_8_0)
	local var_8_0 = MoLiDeErConfig.instance:getOptionResultConfig(arg_8_0)
	local var_8_1 = {}

	if not string.nilorempty(var_8_0.effect) then
		local var_8_2 = string.split(var_8_0.effect, "|")

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			local var_8_3 = string.splitToNumber(iter_8_1, "#")
			local var_8_4 = var_8_3[1]
			local var_8_5 = var_8_3[#var_8_3]

			if var_8_4 == MoLiDeErEnum.OptionEffectType.Round then
				table.insert(var_8_1, tostring(var_8_5))
			elseif var_8_4 == MoLiDeErEnum.OptionEffectType.Execution then
				table.insert(var_8_1, var_0_0.getExecutionCostStr(var_8_5))
			elseif var_8_4 == MoLiDeErEnum.OptionEffectType.Team then
				local var_8_6 = MoLiDeErConfig.instance:getTeamConfig(var_8_3[#var_8_3])

				table.insert(var_8_1, var_8_6.name)
			elseif var_8_4 == MoLiDeErEnum.OptionEffectType.Item then
				local var_8_7 = MoLiDeErConfig.instance:getItemConfig(var_8_3[#var_8_3])

				table.insert(var_8_1, var_8_7.name)
			end
		end
	end

	return var_8_1
end

function var_0_0.getRealRound(arg_9_0, arg_9_1)
	local var_9_0 = MoLiDeErGameModel.instance:getCurGameInfo()

	if var_9_0 == nil then
		return arg_9_0
	end

	local var_9_1 = var_9_0.itemBuffIds

	if var_9_1 and var_9_1[1] then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			local var_9_2 = MoLiDeErConfig.instance:getBuffConfig(iter_9_1)
			local var_9_3 = MoLiDeErGameModel.instance:getCurGameId()

			if not string.nilorempty(var_9_2.effectType) then
				local var_9_4 = string.splitToNumber(var_9_2.effectType, "#")
				local var_9_5 = var_9_4[1]

				if var_9_5 == MoLiDeErEnum.ItemBuffType.MainRoundAdd and arg_9_1 or var_9_5 == MoLiDeErEnum.ItemBuffType.ExtraRoundAdd and not arg_9_1 then
					for iter_9_2 = 3, #var_9_4 do
						if var_9_4[iter_9_2] == var_9_3 then
							arg_9_0 = arg_9_0 + var_9_4[2]

							break
						end
					end
				end
			end
		end
	end

	return arg_9_0
end

function var_0_0.checkIsInSamePosition(arg_10_0, arg_10_1)
	return arg_10_0[1] == arg_10_1[1] and arg_10_0[2] == arg_10_1[2]
end

function var_0_0.getRangeDesc(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = string.splitToNumber(arg_11_1, "#")
	local var_11_1 = string.split(arg_11_2, "#")

	for iter_11_0 = #var_11_0, 1, -1 do
		if arg_11_0 >= var_11_0[iter_11_0] then
			if var_11_1[iter_11_0] then
				return var_11_1[iter_11_0], iter_11_0
			else
				logError("莫莉德尔 角色活动 范围 " .. tostring(iter_11_0) .. "里没有合适的描述")
			end
		end
	end

	logError("莫莉德尔 角色活动 目标 没有合适的描述")

	return var_11_1[1], 1
end

function var_0_0.getPreEventId(arg_12_0)
	local var_12_0 = MoLiDeErConfig.instance:getEventConfig(arg_12_0)

	if string.nilorempty(var_12_0.trigger) then
		return 0
	end

	local var_12_1 = string.split(var_12_0.trigger, "|")
	local var_12_2 = MoLiDeErGameModel.instance:getCurGameInfo()

	if var_12_2 == nil then
		return 0
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_3 = string.splitToNumber(iter_12_1, "#")

		if var_12_3[1] == 2 and var_12_3[2] == 0 then
			for iter_12_2, iter_12_3 in ipairs(var_12_2.newFinishEventList) do
				if iter_12_3.optionId == var_12_3[3] then
					return iter_12_3.finishedEventId or 0
				end
			end
		end
	end

	return 0
end

function var_0_0.getTargetState(arg_13_0)
	if arg_13_0 <= MoLiDeErEnum.ProgressRange.Failed then
		return MoLiDeErEnum.ProgressChangeType.Failed
	elseif arg_13_0 >= MoLiDeErEnum.ProgressRange.Success then
		return MoLiDeErEnum.ProgressChangeType.Success
	else
		return MoLiDeErEnum.ProgressChangeType.Percentage
	end
end

function var_0_0.getTargetTitleByProgress(arg_14_0, arg_14_1)
	local var_14_0 = var_0_0.getTargetState(arg_14_0)
	local var_14_1 = MoLiDeErEnum.TargetDescColor[var_14_0]

	if var_14_0 == MoLiDeErEnum.ProgressChangeType.Failed then
		arg_14_1 = string.format("<s>%s</s>", arg_14_1)
	end

	return string.format("<color=%s>%s</color>", var_14_1, arg_14_1)
end

function var_0_0.isOptionCanChose(arg_15_0)
	local var_15_0 = MoLiDeErGameModel.instance:getCurGameInfo()
	local var_15_1 = var_15_0.teamInfos
	local var_15_2 = 0

	if var_15_0.teamInfos == nil or var_15_0.teamInfos[1] == nil then
		return false
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if var_0_0.isTeamCanChose(var_15_0, iter_15_1, arg_15_0) then
			var_15_2 = var_15_2 + 1
		end
	end

	if var_15_2 <= 0 then
		return false
	end

	local var_15_3 = MoLiDeErConfig.instance:getOptionConfig(arg_15_0)
	local var_15_4 = string.split(var_15_3.effect, "|")
	local var_15_5 = 0

	for iter_15_2, iter_15_3 in ipairs(var_15_4) do
		local var_15_6 = string.splitToNumber(iter_15_3, "#")
		local var_15_7 = var_15_6[1]

		if var_15_7 == MoLiDeErEnum.OptionEffectType.Item then
			local var_15_8 = var_15_6[2]
			local var_15_9 = var_15_6[3]
			local var_15_10 = var_15_0:getEquipInfo(var_15_9)

			if var_15_10 == nil or var_15_10.quantity + var_15_8 < 0 then
				var_15_5 = var_15_5 + 1
			end
		elseif var_15_7 == MoLiDeErEnum.OptionEffectType.Team then
			local var_15_11 = var_15_6[3]
			local var_15_12 = var_15_6[2]
			local var_15_13 = var_15_0:getTeamInfo(var_15_11)

			if var_15_12 < 0 and var_15_13 == nil then
				var_15_5 = var_15_5 + 1
			end
		end
	end

	return var_15_5 <= 0
end

function var_0_0.isTeamCanChose(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1.teamId

	if arg_16_0:canDispatchTeam(var_16_0) == false then
		return false, ToastEnum.Act194CurrentTeamDispatching
	end

	if arg_16_1.roundActionTime <= 0 then
		return false, ToastEnum.Act194TeamCanNotAction
	end

	if arg_16_1.roundActedTime >= arg_16_1.roundActionTime then
		return false, ToastEnum.Act194CurrentTeamActTimesNotMatch
	end

	local var_16_1 = MoLiDeErGameModel.instance:getSelectEventId()

	if arg_16_2 and not var_0_0.isTeamEnable(arg_16_2, var_16_0) then
		return false, ToastEnum.Act194CurrentTeamNotMatchCondition
	end

	if MoLiDeErGameModel.instance:getExecutionCostById(var_16_1, arg_16_2, var_16_0) + arg_16_0.leftRoundEnergy < 0 then
		return false, ToastEnum.Act194ExecutionNotEnough
	end

	return true
end

function var_0_0.calculateExecutionCost(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = MoLiDeErConfig.instance:getBuffConfig(arg_17_0)

	if var_17_0.buffType == MoLiDeErEnum.BuffType.Forever or var_17_0.buffType == MoLiDeErEnum.BuffType.Passive then
		local var_17_1 = string.splitToNumber(var_17_0.effectType, "#")
		local var_17_2 = var_17_1[1]

		if arg_17_4 == nil or var_17_2 == arg_17_4 then
			if var_17_2 == MoLiDeErEnum.ExecutionBuffType.Fixed then
				arg_17_1 = arg_17_1 + var_17_1[2]
			elseif var_17_2 == MoLiDeErEnum.ExecutionBuffType.Percent then
				table.insert(arg_17_2, var_17_1[2])
			elseif var_17_2 == MoLiDeErEnum.ExecutionBuffType.FixedOther and arg_17_3 then
				for iter_17_0 = 3, #var_17_1 do
					if var_17_1[iter_17_0] == arg_17_3 then
						arg_17_1 = arg_17_1 + var_17_1[2]

						break
					end
				end
			end
		end
	end

	return arg_17_1
end

function var_0_0.calculateRoundCost(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = MoLiDeErConfig.instance:getBuffConfig(arg_18_0)

	if var_18_0.buffType == MoLiDeErEnum.BuffType.Forever or var_18_0.buffType == MoLiDeErEnum.BuffType.Passive then
		local var_18_1 = string.splitToNumber(var_18_0.effectType, "#")
		local var_18_2 = var_18_1[1]

		if arg_18_4 == nil or var_18_2 == arg_18_4 then
			if var_18_2 == MoLiDeErEnum.RoundBuffType.Fixed then
				arg_18_1 = math.max(0, arg_18_1 + var_18_1[2])
			elseif var_18_2 == MoLiDeErEnum.RoundBuffType.Percent then
				table.insert(arg_18_2, var_18_1[2])
			elseif var_18_2 == MoLiDeErEnum.RoundBuffType.FixedOther and arg_18_3 then
				for iter_18_0 = 3, #var_18_1 do
					if var_18_1[iter_18_0] == arg_18_3 then
						arg_18_1 = math.max(0, arg_18_1 + var_18_1[2])

						break
					end
				end
			end
		end
	end

	return arg_18_1
end

function var_0_0.getOptionItemCost(arg_19_0)
	local var_19_0 = MoLiDeErConfig.instance:getOptionConfig(arg_19_0)
	local var_19_1 = {}

	if var_19_0 == nil then
		return nil
	end

	if string.nilorempty(var_19_0.effect) then
		return nil
	end

	local var_19_2 = string.split(var_19_0.effect, "|")

	for iter_19_0, iter_19_1 in ipairs(var_19_2) do
		local var_19_3 = string.splitToNumber(iter_19_1, "#")

		if var_19_3[1] == MoLiDeErEnum.OptionEffectType.Item then
			table.insert(var_19_1, var_19_3)
		end
	end

	return var_19_1
end

return var_0_0
