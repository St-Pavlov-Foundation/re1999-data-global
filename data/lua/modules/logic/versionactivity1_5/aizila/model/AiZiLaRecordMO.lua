module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordMO", package.seeall)

local var_0_0 = pureTable("AiZiLaRecordMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.recordId
	arg_1_0.config = arg_1_1
	arg_1_0._groupMOList = {}
	arg_1_0._actId = arg_1_1.activityId
	arg_1_0._recordId = arg_1_1.recordId
	arg_1_0._eventMOList = {}

	local var_1_0 = string.split(arg_1_1.unLockDesc, "|") or {}
	local var_1_1 = GameUtil.splitString2(arg_1_1.eventIds, true) or {}
	local var_1_2 = AiZiLaConfig.instance

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_3 = AiZiLaRecordEventGroupMO.New()

		var_1_3:init(iter_1_0, var_1_0[iter_1_0], arg_1_1)
		table.insert(arg_1_0._groupMOList, var_1_3)

		for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
			local var_1_4 = var_1_2:getEventCo(arg_1_0._actId, iter_1_3)

			if var_1_4 then
				local var_1_5 = AiZiLaRecordEventMO.New()

				var_1_5:init(var_1_4)
				var_1_3:addEventMO(var_1_5)
				table.insert(arg_1_0._eventMOList, var_1_5)
			else
				logError(string.format("export_事件记录 activity:%s,eventId:%s 找不到", arg_1_0._actId, iter_1_3))
			end
		end
	end

	local var_1_6 = #var_1_1 - #var_1_0

	if var_1_6 > 0 then
		logError(string.format("export_事件记录 activity:%s,recordId:%s unLockDesc数量少：%s", arg_1_0._actId, arg_1_0._recordId, var_1_6))
	end
end

function var_0_0.isUnLock(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._groupMOList) do
		if iter_2_1:isUnLock() then
			return true
		end
	end

	return false
end

function var_0_0.isHasRed(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._groupMOList) do
		if iter_3_1:isHasRed() then
			return true
		end
	end

	return false
end

function var_0_0.finishRed(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._groupMOList) do
		iter_4_1:finishRed()
	end
end

function var_0_0.getRedUid(arg_5_0)
	return arg_5_0.id
end

function var_0_0.getRroupMOList(arg_6_0)
	return arg_6_0._groupMOList
end

function var_0_0.getEventMOList(arg_7_0)
	return arg_7_0._eventMOList
end

return var_0_0
