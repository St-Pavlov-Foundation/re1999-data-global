module("modules.logic.critter.model.info.CritterTrainEventInfoMO", package.seeall)

local var_0_0 = pureTable("CritterTrainEventInfoMO")
local var_0_1 = {}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or var_0_1
	arg_1_0.eventId = arg_1_1.eventId or 0
	arg_1_0.remainCount = arg_1_1.remainCount or 0
	arg_1_0.finishCount = arg_1_1.finishCount or 0
	arg_1_0.activeTime = arg_1_1.activeTime or arg_1_0.activeTime or 0
	arg_1_0.addAttributes = CritterHelper.getInitClassMOList(arg_1_1.addAttributes, CritterAttributeMO, arg_1_0.addAttributes)
	arg_1_0.options = CritterHelper.getInitClassMOList(arg_1_1.options, CritterTrainOptionInfoMO, arg_1_0.options)

	arg_1_0:_updateDefineCfg()
end

function var_0_0.setTrainInfoMO(arg_2_0, arg_2_1)
	arg_2_0._trainInfoMO = arg_2_1
end

function var_0_0._updateDefineCfg(arg_3_0)
	if arg_3_0._lastEventId ~= arg_3_0.eventId then
		arg_3_0.config = CritterConfig.instance:getCritterTrainEventCfg(arg_3_0.eventId, arg_3_0.eventId ~= 0)
		arg_3_0.conditionNums = arg_3_0:_splitToNumer(arg_3_0.config and arg_3_0.config.condition)
		arg_3_0.effectAttributeNums = arg_3_0:_splitToNumer(arg_3_0.config and arg_3_0.config.effectAttribute)
		arg_3_0.eventType = arg_3_0.config and arg_3_0.config.type or 0
	end
end

function var_0_0._splitToNumer(arg_4_0, arg_4_1)
	if not string.nilorempty(arg_4_1) then
		return string.splitToNumber(arg_4_1, "#")
	end
end

function var_0_0.getDefineCfg(arg_5_0)
	return arg_5_0.config
end

function var_0_0.getConditionTime(arg_6_0)
	if arg_6_0.conditionNums then
		return arg_6_0.conditionNums[2] or 0
	end

	return 0
end

function var_0_0.getEventType(arg_7_0)
	return arg_7_0.eventType or 0
end

function var_0_0.getFinishCount(arg_8_0)
	return arg_8_0.finishCount or 0
end

function var_0_0.isHasEventAction(arg_9_0)
	if arg_9_0:isEventFinish() then
		return false
	end

	if arg_9_0:isEventActive() then
		return true
	end

	return false
end

function var_0_0.isEventActive(arg_10_0)
	if (arg_10_0.eventType == CritterEnum.EventType.Special or arg_10_0.eventType == CritterEnum.EventType.ActiveTime) and (arg_10_0.remainCount and arg_10_0.remainCount > 0 or arg_10_0.finishCount and arg_10_0.finishCount > 0) then
		return true
	end

	return false
end

function var_0_0.getTrainProcessTime(arg_11_0)
	if arg_11_0._trainInfoMO then
		return arg_11_0._trainInfoMO:getProcessTime()
	end

	return 0
end

function var_0_0.isEventFinish(arg_12_0)
	if arg_12_0.remainCount and arg_12_0.remainCount <= 0 then
		if arg_12_0.eventType == CritterEnum.EventType.ActiveTime and arg_12_0.finishCount and arg_12_0.finishCount <= 0 then
			return false
		end

		return true
	end

	return false
end

function var_0_0.getEventInfoOption(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.options) do
		if iter_13_1.optionId == arg_13_1 then
			return iter_13_1
		end
	end
end

return var_0_0
