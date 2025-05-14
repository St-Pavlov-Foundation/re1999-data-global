module("modules.logic.versionactivity1_5.aizila.model.AiZiLaEpsiodeMO", package.seeall)

local var_0_0 = pureTable("AiZiLaEpsiodeMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.episodeId = arg_1_1
	arg_1_0.activityId = arg_1_2 or VersionActivity1_5Enum.ActivityId.AiZiLa
	arg_1_0.day = 0
	arg_1_0.eventId = 0
	arg_1_0.actionPoint = 0
	arg_1_0.buffIds = {}
	arg_1_0.option = 0
	arg_1_0.optionResultId = 0
	arg_1_0.altitude = 0
	arg_1_0.round = 0
	arg_1_0.costActionPoint = 0
	arg_1_0.enterTimes = 0
	arg_1_0._passRound = 8

	arg_1_0:getConfig()
end

function var_0_0.getConfig(arg_2_0)
	if not arg_2_0._config then
		arg_2_0._config = AiZiLaConfig.instance:getEpisodeCo(arg_2_0.activityId, arg_2_0.episodeId)
		arg_2_0._targetIds = arg_2_0._config and string.splitToNumber(arg_2_0._config.showTargets, "|") or {}

		local var_2_0 = AiZiLaConfig.instance:getPassRoundCo(arg_2_0.activityId, arg_2_0.episodeId)

		if var_2_0 then
			arg_2_0._passRound = var_2_0.round
		end
	end

	return arg_2_0._config
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	if arg_3_1.actionPoint then
		arg_3_0.actionPoint = arg_3_1.actionPoint
	end

	if arg_3_1.day then
		arg_3_0.day = arg_3_1.day
	end

	if arg_3_1.eventId then
		arg_3_0.eventId = arg_3_1.eventId
	end

	if arg_3_1.buffIds then
		local var_3_0 = #arg_3_0.buffIds

		for iter_3_0 = 1, var_3_0 do
			table.remove(arg_3_0.buffIds)
		end

		tabletool.addValues(arg_3_0.buffIds, arg_3_1.buffIds)
	end

	if arg_3_1.option then
		arg_3_0.option = arg_3_1.option
	end

	if arg_3_1.optionResultId then
		arg_3_0.optionResultId = arg_3_1.optionResultId
	end

	if arg_3_1.altitude then
		arg_3_0.altitude = arg_3_1.altitude
	end

	if arg_3_1.round then
		arg_3_0.round = arg_3_1.round
	end

	if arg_3_1.costActionPoint then
		arg_3_0.costActionPoint = arg_3_1.costActionPoint
	end

	if arg_3_1.enterTimes then
		arg_3_0.enterTimes = arg_3_1.enterTimes
	end
end

function var_0_0.getTargetIds(arg_4_0)
	return arg_4_0._targetIds
end

function var_0_0.isPass(arg_5_0)
	if arg_5_0._passRound < arg_5_0.round then
		return true
	end

	if arg_5_0._passRound == arg_5_0.round and arg_5_0.eventId ~= 0 and arg_5_0.option ~= 0 and arg_5_0.optionResultId ~= 0 then
		return true
	end

	return false
end

function var_0_0.isCanSafe(arg_6_0)
	if arg_6_0.actionPoint < 0 then
		return false
	end

	if arg_6_0:isPass() then
		return true
	end

	return false
end

function var_0_0.getRoundCfg(arg_7_0)
	return AiZiLaConfig.instance:getRoundCo(arg_7_0.activityId, arg_7_0.episodeId, arg_7_0.round)
end

function var_0_0.getCostActionPoint(arg_8_0)
	return arg_8_0.costActionPoint
end

return var_0_0
