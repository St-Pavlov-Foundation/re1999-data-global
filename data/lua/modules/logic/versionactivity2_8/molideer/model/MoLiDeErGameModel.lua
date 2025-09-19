module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErGameModel", package.seeall)

local var_0_0 = class("MoLiDeErGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:init()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:init()
end

function var_0_0.init(arg_3_0)
	arg_3_0._episodeInfoDic = {}
	arg_3_0._curGameConfig = nil
	arg_3_0._curGameId = nil
	arg_3_0._skipGameTriggerDic = {}
end

function var_0_0.setEpisodeInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = arg_4_2.episodeId

	if not arg_4_0._episodeInfoDic[arg_4_1] then
		arg_4_0._episodeInfoDic[arg_4_1] = {}
	end

	local var_4_1

	if not arg_4_0._episodeInfoDic[arg_4_1][var_4_0] then
		local var_4_2 = MoLiDeErGameMo.New()

		var_4_2:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4)

		arg_4_0._episodeInfoDic[arg_4_1][var_4_0] = var_4_2
	else
		local var_4_3 = arg_4_0._episodeInfoDic[arg_4_1][var_4_0]
		local var_4_4 = {}
		local var_4_5 = {}
		local var_4_6 = {}
		local var_4_7 = {}
		local var_4_8 = {}

		if arg_4_2.finishedEventInfos ~= nil then
			for iter_4_0, iter_4_1 in ipairs(arg_4_2.finishedEventInfos) do
				local var_4_9 = iter_4_1.finishedEventId

				if var_4_3:isNewFinishEvent(var_4_9) then
					table.insert(var_4_4, iter_4_1)

					local var_4_10 = var_4_3:getEventDispatchTeam(var_4_9)

					if var_4_10 then
						var_4_7[var_4_10] = var_4_9
						var_4_8[var_4_9] = var_4_10
					end
				end
			end
		end

		if var_4_4[2] ~= nil then
			table.sort(var_4_4, arg_4_0.finishSort)
		end

		local var_4_11 = {}
		local var_4_12 = {}

		if arg_4_2.eventInfos ~= nil then
			for iter_4_2, iter_4_3 in ipairs(arg_4_2.eventInfos) do
				if var_4_3:isNewEvent(iter_4_3.eventId) then
					table.insert(var_4_11, iter_4_3)
				else
					table.insert(var_4_12, iter_4_3)

					local var_4_13 = iter_4_3.teamId
					local var_4_14 = iter_4_3.eventId

					if var_4_13 == nil or var_4_13 == 0 then
						local var_4_15 = var_4_3:getEventDispatchTeam(var_4_14)

						if var_4_15 then
							var_4_7[var_4_13] = var_4_14
							var_4_8[var_4_14] = var_4_15
						end
					elseif var_4_3:isDispatchTeam(var_4_13) == false then
						var_4_5[var_4_13] = var_4_14
						var_4_6[var_4_14] = var_4_13
					end
				end
			end
		end

		var_4_3:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4)

		var_4_3.newFinishEventList = var_4_4
		var_4_3.newEventList = var_4_11
		var_4_3.existEventList = var_4_12
		var_4_3.newDispatchTeam = var_4_5
		var_4_3.newDispatchEventDic = var_4_6
		var_4_3.newBackTeam = var_4_7
		var_4_3.newBackTeamEventDic = var_4_8
	end

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameInfoUpdate, arg_4_1, var_4_0)
end

function var_0_0.getGameInfo(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._episodeInfoDic[arg_5_1] then
		return nil
	end

	return arg_5_0._episodeInfoDic[arg_5_1][arg_5_2]
end

function var_0_0.setCurGameData(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == nil then
		arg_6_2 = MoLiDeErConfig.instance:getGameConfig(arg_6_1)
	end

	arg_6_0._curGameId = arg_6_1
	arg_6_0._curGameConfig = arg_6_2
end

function var_0_0.getCurGameConfig(arg_7_0)
	return arg_7_0._curGameConfig
end

function var_0_0.getCurGameId(arg_8_0)
	return arg_8_0._curGameId
end

function var_0_0.finishSort(arg_9_0, arg_9_1)
	local var_9_0 = MoLiDeErConfig.instance:getEventConfig(arg_9_0.finishedEventId)
	local var_9_1 = MoLiDeErConfig.instance:getEventConfig(arg_9_1.finishedEventId)

	if var_9_0.eventType == var_9_1.eventType then
		return var_9_0.eventId >= var_9_1.eventId
	end

	return var_9_0.eventType >= var_9_1.eventType
end

function var_0_0.isMainConditionComplete(arg_10_0)
	return true
end

function var_0_0.isExtraConditionComplete(arg_11_0)
	return true
end

function var_0_0.getCurExecution(arg_12_0)
	local var_12_0 = arg_12_0:getCurGameInfo()

	return var_12_0.leftRoundEnergy, var_12_0.previousRoundEnergy
end

function var_0_0.getCurExecutionCost(arg_13_0)
	local var_13_0 = arg_13_0:getSelectEventId()
	local var_13_1 = arg_13_0:getSelectOptionId()
	local var_13_2 = arg_13_0:getSelectTeamId()

	return arg_13_0:getExecutionCostById(var_13_0, var_13_1, var_13_2)
end

function var_0_0.getExecutionCostById(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_1 == nil or arg_14_2 == nil then
		return 0
	end

	local var_14_0 = MoLiDeErConfig.instance:getOptionCost(arg_14_2, MoLiDeErEnum.OptionCostType.Execution)

	if var_14_0 == 0 then
		return 0
	end

	return arg_14_0:getExecutionCost(var_14_0, arg_14_3)
end

function var_0_0.getExecutionCost(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getCurGameInfo()
	local var_15_1 = {}
	local var_15_2 = {}

	if var_15_0.itemBuffIds then
		for iter_15_0, iter_15_1 in ipairs(var_15_0.itemBuffIds) do
			arg_15_1 = MoLiDeErHelper.calculateExecutionCost(iter_15_1, arg_15_1, var_15_1, arg_15_2)
			var_15_2[iter_15_1] = true
		end
	end

	if arg_15_2 then
		local var_15_3 = var_15_0:getTeamInfo(arg_15_2)

		if var_15_3 then
			for iter_15_2, iter_15_3 in ipairs(var_15_3.buffIds) do
				arg_15_1 = MoLiDeErHelper.calculateExecutionCost(iter_15_3, arg_15_1, var_15_1, arg_15_2)
				var_15_2[iter_15_3] = true
			end
		end

		for iter_15_4, iter_15_5 in ipairs(var_15_0.buffIds) do
			if not var_15_2[iter_15_5] then
				arg_15_1 = MoLiDeErHelper.calculateExecutionCost(iter_15_5, arg_15_1, var_15_1, arg_15_2, MoLiDeErEnum.ExecutionBuffType.FixedOther)
			end
		end
	end

	for iter_15_6, iter_15_7 in ipairs(var_15_1) do
		arg_15_1 = arg_15_1 * (1 + iter_15_7 * 0.01)
	end

	arg_15_1 = math.ceil(arg_15_1)

	return arg_15_1
end

function var_0_0.getRoundCostById(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_1 == nil or arg_16_2 == nil then
		return 0
	end

	local var_16_0 = MoLiDeErConfig.instance:getOptionCost(arg_16_2, MoLiDeErEnum.OptionCostType.Round)

	if var_16_0 == 0 then
		return 0
	end

	return arg_16_0:getRoundCost(var_16_0, arg_16_3)
end

function var_0_0.getRoundCost(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getCurGameInfo()
	local var_17_1 = {}
	local var_17_2 = {}

	if var_17_0.itemBuffIds then
		for iter_17_0, iter_17_1 in ipairs(var_17_0.itemBuffIds) do
			arg_17_1 = MoLiDeErHelper.calculateRoundCost(iter_17_1, arg_17_1, var_17_1, arg_17_2)
			var_17_2[iter_17_1] = true
		end
	end

	if arg_17_2 then
		local var_17_3 = var_17_0:getTeamInfo(arg_17_2)

		if var_17_3 then
			for iter_17_2, iter_17_3 in ipairs(var_17_3.buffIds) do
				arg_17_1 = MoLiDeErHelper.calculateRoundCost(iter_17_3, arg_17_1, var_17_1, arg_17_2)
				var_17_2[iter_17_3] = true
			end
		end
	end

	for iter_17_4, iter_17_5 in ipairs(var_17_0.buffIds) do
		if not var_17_2[iter_17_5] then
			arg_17_1 = MoLiDeErHelper.calculateRoundCost(iter_17_5, arg_17_1, var_17_1, arg_17_2, MoLiDeErEnum.RoundBuffType.FixedOther)
		end
	end

	for iter_17_6, iter_17_7 in ipairs(var_17_1) do
		arg_17_1 = arg_17_1 * (1 + iter_17_7 * 0.01)
	end

	arg_17_1 = math.ceil(arg_17_1)

	return arg_17_1
end

function var_0_0.getCurGameInfo(arg_18_0)
	local var_18_0 = MoLiDeErModel.instance:getCurActId()
	local var_18_1 = MoLiDeErModel.instance:getCurEpisodeId()

	return arg_18_0:getGameInfo(var_18_0, var_18_1)
end

function var_0_0.getCurRound(arg_19_0)
	local var_19_0 = MoLiDeErModel.instance:getCurActId()
	local var_19_1 = MoLiDeErModel.instance:getCurEpisodeId()

	return arg_19_0:getRound(var_19_0, var_19_1)
end

function var_0_0.getRound(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getGameInfo(arg_20_1, arg_20_2)

	if var_20_0 == nil then
		return 0
	end

	return var_20_0.currentRound or 0
end

function var_0_0.setSelectTeamId(arg_21_0, arg_21_1)
	arg_21_0._teamId = arg_21_1

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameTeamSelect, arg_21_1)
end

function var_0_0.getSelectTeamId(arg_22_0)
	return arg_22_0._teamId
end

function var_0_0.setSelectItemId(arg_23_0, arg_23_1)
	arg_23_0._itemId = arg_23_1

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameItemSelect, arg_23_1)
end

function var_0_0.getSelectItemId(arg_24_0)
	return arg_24_0._itemId
end

function var_0_0.setSelectEventId(arg_25_0, arg_25_1)
	arg_25_0._eventId = arg_25_1

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameEventSelect, arg_25_1)
end

function var_0_0.getSelectEventId(arg_26_0)
	return arg_26_0._eventId
end

function var_0_0.setSelectOptionId(arg_27_0, arg_27_1)
	arg_27_0._optionId = arg_27_1

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameOptionSelect, arg_27_1)

	local var_27_0 = arg_27_0:getCurGameInfo()
	local var_27_1

	if arg_27_1 and arg_27_0._eventId then
		local var_27_2 = arg_27_0:getCurTeamData()

		for iter_27_0, iter_27_1 in ipairs(var_27_2) do
			local var_27_3 = iter_27_1.teamId

			if MoLiDeErHelper.isTeamEnable(arg_27_1, var_27_3) and var_27_0:canDispatchTeam(var_27_3) and iter_27_1.roundActionTime > 0 and iter_27_1.roundActedTime < iter_27_1.roundActionTime then
				if var_27_1 == nil then
					var_27_1 = var_27_3
				end

				if MoLiDeErHelper.isTeamBuffed(arg_27_1, var_27_3) then
					var_27_1 = var_27_3

					break
				end
			end
		end
	end

	arg_27_0:setSelectTeamId(var_27_1)
end

function var_0_0.getSelectOptionId(arg_28_0)
	return arg_28_0._optionId
end

function var_0_0.isTeamDispatched(arg_29_0, arg_29_1)
	return false
end

function var_0_0.getCurTeamData(arg_30_0)
	return arg_30_0:getCurGameInfo().teamInfos
end

function var_0_0.enterGame(arg_31_0)
	arg_31_0:resetSelect()
end

function var_0_0.resetGame(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0:resetSelect()
	arg_32_0:removeInfoMo(arg_32_1, arg_32_2)
end

function var_0_0.resetSelect(arg_33_0)
	arg_33_0:setSelectEventId(nil)
	arg_33_0:setSelectItemId(nil)
	arg_33_0:setSelectOptionId(nil)
	arg_33_0:setSelectTeamId(nil)
end

function var_0_0.removeInfoMo(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0._episodeInfoDic[arg_34_1] then
		arg_34_0._episodeInfoDic[arg_34_1][arg_34_2] = nil
	end
end

function var_0_0.setSkipGameTrigger(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0

	if not arg_35_0._skipGameTriggerDic[arg_35_1] then
		var_35_0 = {}
		arg_35_0._skipGameTriggerDic[arg_35_1] = var_35_0
	else
		var_35_0 = arg_35_0._skipGameTriggerDic[arg_35_1]
	end

	var_35_0[arg_35_2] = arg_35_3
end

function var_0_0.getSkipGameTrigger(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0._skipGameTriggerDic[arg_36_1] then
		return false
	end

	return arg_36_0._skipGameTriggerDic[arg_36_1][arg_36_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
