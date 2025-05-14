module("modules.logic.critter.model.info.CritterTrainInfoMO", package.seeall)

local var_0_0 = pureTable("CritterTrainInfoMO")
local var_0_1 = {}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or var_0_1
	arg_1_0.heroId = arg_1_1.heroId or 0
	arg_1_0.startTime = arg_1_1.startTime or 0
	arg_1_0.endTime = arg_1_1.endTime or 0
	arg_1_0.fastForwardTime = arg_1_1.fastForwardTime or 0
	arg_1_0.trainTime = arg_1_1.trainTime or arg_1_0.trainTime or 0
	arg_1_0.events = CritterHelper.getInitClassMOList(arg_1_1.events, CritterTrainEventInfoMO, arg_1_0.events)
	arg_1_0.eventTimePoints = arg_1_0.eventTimePoints or {}

	arg_1_0:updateEventActiveTime()
end

function var_0_0.updateEventActiveTime(arg_2_0)
	local var_2_0 = 0
	local var_2_1 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.events) do
		if iter_2_1:getEventType() == CritterEnum.EventType.ActiveTime then
			var_2_1 = var_2_1 + 1
			arg_2_0.eventTimePoints[var_2_1] = var_2_0
			var_2_0 = var_2_0 + iter_2_1:getConditionTime()
		end

		iter_2_1:setTrainInfoMO(arg_2_0)
	end

	if var_2_1 < #arg_2_0.eventTimePoints then
		while var_2_1 < #arg_2_0.eventTimePoints do
			table.remove(arg_2_0.eventTimePoints, #arg_2_0.eventTimePoints)
		end
	end
end

function var_0_0.setCritterMO(arg_3_0, arg_3_1)
	arg_3_0._critterMO = arg_3_1
end

function var_0_0.isTraining(arg_4_0)
	if arg_4_0.heroId and arg_4_0.heroId ~= 0 then
		return arg_4_0.startTime + arg_4_0.fastForwardTime < arg_4_0.endTime
	end

	return false
end

function var_0_0.isTrainFinish(arg_5_0)
	if arg_5_0.heroId and arg_5_0.heroId ~= 0 then
		return arg_5_0:getCurCdTime() <= 0
	end

	return false
end

function var_0_0.isCultivating(arg_6_0)
	if arg_6_0.trainInfo.heroId and arg_6_0.trainInfo.heroId ~= 0 and (arg_6_0:getCurCdTime() > 0 or arg_6_0._critterMO.finishTrain ~= true) then
		return true
	end

	return false
end

function var_0_0.isHasEventTrigger(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.events do
		local var_7_0 = arg_7_0.events[iter_7_0]

		if CritterEnum.NeedActionEventTypeDict[var_7_0:getEventType()] and var_7_0:isHasEventAction() then
			return true
		end
	end

	return false
end

function var_0_0.checkRoundFinish(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0 = 1, #arg_8_0.events do
		local var_8_0 = arg_8_0.events[iter_8_0]

		if (arg_8_2 == nil or var_8_0:getEventType() == arg_8_2) and arg_8_1 > var_8_0:getFinishCount() then
			return false
		end
	end

	return true
end

function var_0_0.getTotalTime(arg_9_0)
	return arg_9_0.endTime - arg_9_0.startTime
end

function var_0_0.getProcessTime(arg_10_0)
	local var_10_0 = ServerTime.now() - arg_10_0.startTime + arg_10_0.fastForwardTime

	if var_10_0 > arg_10_0.trainTime then
		return arg_10_0.trainTime
	end

	return var_10_0
end

function var_0_0.getCurCdTime(arg_11_0)
	local var_11_0 = arg_11_0.trainTime - arg_11_0:getProcessTime()

	if var_11_0 < 0 then
		return 0
	end

	return var_11_0
end

function var_0_0.getProcess(arg_12_0)
	if arg_12_0.endTime ~= 0 then
		local var_12_0 = arg_12_0:getProcessTime()
		local var_12_1 = arg_12_0.trainTime

		if var_12_1 > 0 and var_12_0 > 0 then
			return var_12_0 / var_12_1
		end
	end

	return 0
end

function var_0_0.isFinishAllEvent(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.events) do
		if CritterEnum.NeedActionEventTypeDict[iter_13_1:getEventType()] and not iter_13_1:isEventFinish() then
			return false
		end
	end

	return true
end

function var_0_0.selectFinishEvent(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.events) do
		if iter_14_1.eventId == arg_14_1 then
			iter_14_1.remainCount = iter_14_1.remainCount - 1
			iter_14_1.finishCount = iter_14_1.finishCount + 1
		end
	end
end

function var_0_0.getEvents(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.events) do
		if iter_15_1.eventId == arg_15_1 then
			return iter_15_1
		end
	end
end

function var_0_0.getEventOptions(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.events) do
		if iter_16_1.eventId == arg_16_1 then
			return iter_16_1.options
		end
	end
end

function var_0_0.getEventOptionMOByOptionId(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.events) do
		if iter_17_1.eventId == arg_17_1 then
			return iter_17_1:getEventInfoOption(arg_17_2)
		end
	end
end

function var_0_0.getAddAttributeValue(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.events) do
		for iter_18_2, iter_18_3 in ipairs(iter_18_1.addAttributes) do
			if iter_18_3.attributeId == arg_18_1 then
				var_18_0 = var_18_0 + iter_18_3.value
			end
		end
	end

	return var_18_0
end

return var_0_0
