module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordEventMO", package.seeall)

local var_0_0 = pureTable("AiZiLaRecordEventMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.eventId
	arg_1_0.eventId = arg_1_1.eventId
	arg_1_0.config = arg_1_1
	arg_1_0._actId = arg_1_1.activityId

	if arg_1_1 and not string.nilorempty(arg_1_1.optionIds) then
		arg_1_0._optionIds = string.splitToNumber(arg_1_1.optionIds, "|")
	end

	arg_1_0._optionIds = arg_1_0._optionIds or {}
	arg_1_0._redPointKey = AiZiLaHelper.getRedKey(RedDotEnum.DotNode.V1a5AiZiLaRecordEventNew, arg_1_0.eventId)
end

function var_0_0.isFinished(arg_2_0)
	local var_2_0 = AiZiLaModel.instance

	if not var_2_0:isSelectEventId(arg_2_0.eventId) then
		return false
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._optionIds) do
		if var_2_0:isSelectOptionId(iter_2_1) then
			return true
		end
	end

	return false
end

function var_0_0.getSelectOptionCfg(arg_3_0)
	local var_3_0 = AiZiLaModel.instance
	local var_3_1 = AiZiLaConfig.instance

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._optionIds) do
		if var_3_0:isSelectOptionId(iter_3_1) then
			local var_3_2 = var_3_1:getOptionCo(arg_3_0._actId, iter_3_1)

			if var_3_2 then
				return var_3_2
			end
		end
	end
end

function var_0_0.isHasRed(arg_4_0)
	if arg_4_0:isFinished() and not AiZiLaHelper.isFinishRed(arg_4_0._redPointKey) then
		return true
	end

	return false
end

function var_0_0.finishRed(arg_5_0)
	AiZiLaHelper.finishRed(arg_5_0._redPointKey, true)
end

function var_0_0.getRedUid(arg_6_0)
	return arg_6_0.eventId
end

return var_0_0
