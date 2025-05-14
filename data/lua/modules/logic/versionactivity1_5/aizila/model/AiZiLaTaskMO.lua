module("modules.logic.versionactivity1_5.aizila.model.AiZiLaTaskMO", package.seeall)

local var_0_0 = pureTable("AiZiLaTaskMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1.id
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.config = arg_1_1
	arg_1_0.taskMO = arg_1_2
	arg_1_0.preFinish = false
	arg_1_0.showTypeTab = false
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.taskMO = arg_2_1
end

function var_0_0.isMainTask(arg_3_0)
	if arg_3_0.config and arg_3_0.config.showType == 1 then
		return true
	end

	return false
end

function var_0_0.getLineHeight(arg_4_0)
	if arg_4_0.showTypeTab then
		return AiZiLaEnum.UITaskItemHeight.ItemCell + AiZiLaEnum.UITaskItemHeight.ItemTab
	end

	return AiZiLaEnum.UITaskItemHeight.ItemCell
end

function var_0_0.isLock(arg_5_0)
	return arg_5_0.taskMO == nil
end

function var_0_0.setShowTab(arg_6_0, arg_6_1)
	arg_6_0.showTypeTab = arg_6_1
end

function var_0_0.isFinished(arg_7_0)
	if arg_7_0.preFinish then
		return true
	end

	if arg_7_0.taskMO then
		return arg_7_0.taskMO.finishCount > 0
	end

	return false
end

function var_0_0.getMaxProgress(arg_8_0)
	return arg_8_0.config and arg_8_0.config.maxProgress or 0
end

function var_0_0.getFinishProgress(arg_9_0)
	return arg_9_0.taskMO and arg_9_0.taskMO.progress or 0
end

function var_0_0.alreadyGotReward(arg_10_0)
	local var_10_0 = arg_10_0:getMaxProgress()

	if var_10_0 > 0 and arg_10_0.taskMO then
		return var_10_0 <= arg_10_0.taskMO.progress and arg_10_0.taskMO.finishCount == 0
	end

	return false
end

return var_0_0
