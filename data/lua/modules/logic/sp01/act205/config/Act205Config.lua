module("modules.logic.sp01.act205.config.Act205Config", package.seeall)

local var_0_0 = class("Act205Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity205_const",
		"actvity205_stage",
		"activity205_dicegoal",
		"activity205_dicepool",
		"actvity205_mini_game_reward",
		"activity205_card",
		"activity205_card_settle"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "activity205_const" then
		arg_2_0._constConfig = arg_2_2
	elseif arg_2_1 == "actvity205_stage" then
		arg_2_0._stageConfig = arg_2_2
	elseif arg_2_1 == "activity205_dicegoal" then
		arg_2_0._oceanDiceGoalConfig = arg_2_2
	elseif arg_2_1 == "activity205_dicepool" then
		arg_2_0._oceanDicePoolConfig = arg_2_2
	elseif arg_2_1 == "actvity205_mini_game_reward" then
		arg_2_0.miniGameRewardConfig = arg_2_2
	elseif arg_2_1 == "activity205_card" then
		arg_2_0:_onCardConfigLoaded(arg_2_2)
	end
end

function var_0_0._onCardConfigLoaded(arg_3_0, arg_3_1)
	arg_3_0._type2CardsDict = {}
	arg_3_0._restrainedDict = {}
	arg_3_0._beRestrainedDict = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.configList) do
		local var_3_0 = iter_3_1.type
		local var_3_1 = arg_3_0._type2CardsDict[var_3_0]

		if not var_3_1 then
			var_3_1 = {}
			arg_3_0._type2CardsDict[var_3_0] = var_3_1
		end

		var_3_1[#var_3_1 + 1] = iter_3_1.id

		if not string.nilorempty(iter_3_1.restrain) then
			local var_3_2 = string.splitToNumber(iter_3_1.restrain, "#")

			arg_3_0._restrainedDict[iter_3_1.id] = {}

			for iter_3_2, iter_3_3 in ipairs(var_3_2) do
				arg_3_0._restrainedDict[iter_3_1.id][iter_3_3] = true

				if not arg_3_0._beRestrainedDict[iter_3_3] then
					arg_3_0._beRestrainedDict[iter_3_3] = {}
				end

				arg_3_0._beRestrainedDict[iter_3_3][iter_3_1.id] = true
			end
		end
	end
end

function var_0_0.getConstConfig(arg_4_0, arg_4_1)
	return arg_4_0._constConfig.configDict[arg_4_1]
end

function var_0_0.getAct205Const(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0
	local var_5_1 = arg_5_0:getConstConfig(arg_5_1)

	if var_5_1 then
		var_5_0 = var_5_1.value

		if arg_5_2 then
			var_5_0 = tonumber(var_5_0)
		end
	end

	return var_5_0
end

function var_0_0.getStageConfig(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0._stageConfig.configDict[arg_6_1] and arg_6_0._stageConfig.configDict[arg_6_1][arg_6_2]
end

function var_0_0.getGameStageOpenTimeStamp(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0
	local var_7_1 = arg_7_0:getStageConfig(arg_7_1, arg_7_2)

	if var_7_1 then
		local var_7_2 = var_7_1.startTime

		var_7_0 = TimeUtil.stringToTimestamp(var_7_2)
	end

	return var_7_0
end

function var_0_0.getGameStageEndTimeStamp(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0
	local var_8_1 = arg_8_0:getStageConfig(arg_8_1, arg_8_2)

	if var_8_1 then
		local var_8_2 = var_8_1.endTime

		var_8_0 = TimeUtil.stringToTimestamp(var_8_2)
	end

	return var_8_0
end

function var_0_0.getDiceGoalConfig(arg_9_0, arg_9_1)
	return arg_9_0._oceanDiceGoalConfig.configDict[arg_9_1]
end

function var_0_0.getDiceGoalConfigList(arg_10_0)
	return arg_10_0._oceanDiceGoalConfig.configList
end

function var_0_0.getDicePoolConfig(arg_11_0, arg_11_1)
	return arg_11_0._oceanDicePoolConfig.configDict[arg_11_1]
end

function var_0_0.getDicePoolConfigList(arg_12_0)
	return arg_12_0._oceanDicePoolConfig.configList
end

function var_0_0.getGameRewardConfig(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0.miniGameRewardConfig.configDict[arg_13_1] and arg_13_0.miniGameRewardConfig.configDict[arg_13_1][arg_13_2]
end

function var_0_0.getWinDiceConfig(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0:getDicePoolConfigList()) do
		if iter_14_1.winDice == 1 then
			return iter_14_1
		end
	end
end

function var_0_0.getAct205CardCfg(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = lua_activity205_card.configDict[arg_15_1]

	if not var_15_0 and arg_15_2 then
		logError(string.format("Act205Config:getAct205CardCfg error, cfg is nil, cardId:%s", arg_15_1))
	end

	return var_15_0
end

function var_0_0.getCardType(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getAct205CardCfg(arg_16_1, true)

	return var_16_0 and var_16_0.type
end

function var_0_0.getCardName(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getAct205CardCfg(arg_17_1, true)

	return var_17_0 and var_17_0.name
end

function var_0_0.getCardDesc(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getAct205CardCfg(arg_18_1, true)

	return var_18_0 and var_18_0.desc
end

function var_0_0.getCardImg(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getAct205CardCfg(arg_19_1, true)

	return var_19_0 and var_19_0.img
end

function var_0_0.getCardWeight(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = 0
	local var_20_1 = arg_20_0:getAct205CardCfg(arg_20_1, true)

	if var_20_1 then
		var_20_0 = var_20_1.weight

		if arg_20_2 then
			var_20_0 = var_20_0 - var_20_1.subWeight
			var_20_0 = math.max(0, var_20_0)
		end
	end

	return var_20_0
end

function var_0_0.getSpEff(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getAct205CardCfg(arg_21_1, true)

	return var_21_0 and var_21_0.spEff
end

function var_0_0.isSpCard(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getSpEff(arg_22_1)

	return var_22_0 and var_22_0 ~= 0
end

function var_0_0.getCardTypeDict(arg_23_0)
	return arg_23_0._type2CardsDict
end

function var_0_0.getAct205CardSettleCfg(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = lua_activity205_card_settle.configDict[arg_24_1]

	if not var_24_0 and arg_24_2 then
		logError(string.format("Act205Config:getAct205CardSettleCfg error, cfg is nil, point:%s", arg_24_1))
	end

	return var_24_0
end

function var_0_0.getPointList(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(lua_activity205_card_settle.configList) do
		var_25_0[iter_25_0] = iter_25_1.point
	end

	return var_25_0
end

function var_0_0.getRewardId(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getAct205CardSettleCfg(arg_26_1, true)

	return var_26_0 and var_26_0.rewardId
end

function var_0_0.getIsCardRestrain(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0:isSpCard(arg_27_1) then
		return
	end

	return arg_27_0._restrainedDict[arg_27_1] and arg_27_0._restrainedDict[arg_27_1][arg_27_2]
end

function var_0_0.getIsCardBeRestrained(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0:isSpCard(arg_28_1) then
		return
	end

	return arg_28_0._beRestrainedDict[arg_28_1] and arg_28_0._beRestrainedDict[arg_28_1][arg_28_2]
end

function var_0_0.getBeRestrainedCard(arg_29_0, arg_29_1)
	local var_29_0

	if arg_29_0._beRestrainedDict[arg_29_1] then
		local var_29_1 = {}

		for iter_29_0, iter_29_1 in pairs(arg_29_0._beRestrainedDict[arg_29_1]) do
			var_29_1[#var_29_1 + 1] = iter_29_0
		end

		var_29_0 = var_29_1[math.random(1, #var_29_1)]
	end

	return var_29_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
