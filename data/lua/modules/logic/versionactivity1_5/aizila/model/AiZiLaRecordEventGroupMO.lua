module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordEventGroupMO", package.seeall)

local var_0_0 = pureTable("AiZiLaRecordEventGroupMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.lockDesc = arg_1_2 or ""
	arg_1_0._eventMOList = {}
	arg_1_0._recordCfg = arg_1_3
end

function var_0_0.addEventMO(arg_2_0, arg_2_1)
	table.insert(arg_2_0._eventMOList, arg_2_1)
end

function var_0_0.isUnLock(arg_3_0)
	if arg_3_0:getFinishedEventMO() then
		return true
	end

	return false
end

function var_0_0.getFinishedEventMO(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._eventMOList) do
		if iter_4_1:isFinished() then
			return iter_4_1
		end
	end
end

function var_0_0.isHasRed(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._eventMOList) do
		if iter_5_1:isHasRed() then
			return true
		end
	end

	return false
end

function var_0_0.finishRed(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._eventMOList) do
		if iter_6_1:isFinished() then
			iter_6_1:finishRed()
		end
	end
end

function var_0_0.getRedUid(arg_7_0)
	local var_7_0 = arg_7_0:getFinishedEventMO() or arg_7_0._eventMOList[1]

	return var_7_0 and var_7_0:getRedUid() or arg_7_0.id
end

function var_0_0.getLockDesc(arg_8_0)
	local var_8_0 = arg_8_0._recordCfg.unLockDesc

	return (string.split(var_8_0, "|") or {})[arg_8_0.id] or ""
end

return var_0_0
