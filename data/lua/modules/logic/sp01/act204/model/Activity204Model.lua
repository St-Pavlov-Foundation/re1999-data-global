module("modules.logic.sp01.act204.model.Activity204Model", package.seeall)

local var_0_0 = class("Activity204Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.localPrefsDict = {}
end

function var_0_0.getActId(arg_3_0)
	return arg_3_0._activityId
end

function var_0_0.isActivityOnline(arg_4_0)
	local var_4_0 = arg_4_0:getActId()

	if not var_4_0 then
		return false
	end

	return ActivityModel.instance:isActOnLine(var_4_0)
end

function var_0_0.setActInfo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.activityId
	local var_5_1 = arg_5_1.info
	local var_5_2 = arg_5_1.taskInfos

	arg_5_0:getActMo(var_5_0):updateInfo(var_5_1, var_5_2)

	arg_5_0._activityId = var_5_0
end

function var_0_0.getActMo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	if not var_6_0 then
		var_6_0 = Activity204MO.New()

		var_6_0:init(arg_6_1)
		arg_6_0:addAtLast(var_6_0)
	end

	return var_6_0
end

function var_0_0.onFinishAct204Task(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getById(arg_7_1.activityId)

	if var_7_0 then
		var_7_0:finishTask(arg_7_1.taskId)
	end
end

function var_0_0.onGetAct204MilestoneReward(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getById(arg_8_1.activityId)

	if var_8_0 then
		var_8_0:acceptRewards(arg_8_1.getMilestoneProgress)
	end
end

function var_0_0.onGetAct204DailyCollection(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getById(arg_9_1.activityId)

	if var_9_0 then
		var_9_0:onGetDailyCollection()
	end
end

function var_0_0.onAct204TaskPush(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getById(arg_10_1.activityId)

	if var_10_0 then
		var_10_0:pushTask(arg_10_1.act204Tasks, arg_10_1.deleteTasks)
	end
end

function var_0_0.onGetOnceBonusReply(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getById(arg_11_1.activityId)

	if var_11_0 then
		var_11_0:onGetOnceBonus(arg_11_1)
	end
end

function var_0_0.getLocalPrefsTab(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:prefabKeyPrefs(arg_12_1, arg_12_2)

	if not arg_12_0.localPrefsDict[var_12_0] then
		local var_12_1 = {}
		local var_12_2 = Activity204Controller.instance:getPlayerPrefs(var_12_0)
		local var_12_3 = GameUtil.splitString2(var_12_2, true)

		if var_12_3 then
			for iter_12_0, iter_12_1 in ipairs(var_12_3) do
				var_12_1[iter_12_1[1]] = iter_12_1[2]
			end
		end

		arg_12_0.localPrefsDict[var_12_0] = var_12_1
	end

	return arg_12_0.localPrefsDict[var_12_0]
end

function var_0_0.getLocalPrefsState(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	return arg_13_0:getLocalPrefsTab(arg_13_1, arg_13_2)[arg_13_3] or arg_13_4
end

function var_0_0.setLocalPrefsState(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_0:getLocalPrefsTab(arg_14_1, arg_14_2)

	if var_14_0[arg_14_3] == arg_14_4 then
		return
	end

	var_14_0[arg_14_3] = arg_14_4

	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		table.insert(var_14_1, string.format("%s#%s", iter_14_0, iter_14_1))
	end

	local var_14_2 = table.concat(var_14_1, "|")
	local var_14_3 = arg_14_0:prefabKeyPrefs(arg_14_1, arg_14_2)

	Activity204Controller.instance:setPlayerPrefs(var_14_3, var_14_2)
end

function var_0_0.prefabKeyPrefs(arg_15_0, arg_15_1, arg_15_2)
	if string.nilorempty(arg_15_1) then
		return arg_15_1
	end

	return (string.format("%s_%s", arg_15_1, arg_15_2))
end

function var_0_0.checkReadTasks(arg_16_0, arg_16_1)
	if arg_16_1 then
		for iter_16_0, iter_16_1 in pairs(arg_16_1) do
			arg_16_0:checkReadTask(iter_16_1)
		end
	end
end

function var_0_0.checkReadTask(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	local var_17_0 = arg_17_0:getActMo(arg_17_0:getActId())

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0:getTaskInfo(arg_17_1)

	if not var_17_1 then
		return
	end

	if var_17_1.hasGetBonus then
		return
	end

	if var_17_0:checkTaskCanReward(var_17_1) then
		return
	end

	TaskRpc.instance:sendFinishReadTaskRequest(arg_17_1)
end

function var_0_0.hasNewTask(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getActMo(arg_18_1)

	return var_18_0 and var_18_0:hasNewTask()
end

function var_0_0.recordHasReadNewTask(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getActMo(arg_19_1)

	if var_19_0 then
		var_19_0:recordHasReadNewTask()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
