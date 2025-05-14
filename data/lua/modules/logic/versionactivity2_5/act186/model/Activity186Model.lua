module("modules.logic.versionactivity2_5.act186.model.Activity186Model", package.seeall)

local var_0_0 = class("Activity186Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.localPrefsDict = {}
end

function var_0_0.getActId(arg_3_0)
	local var_3_0 = ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.Act186)

	return var_3_0 and var_3_0[1]
end

function var_0_0.isActivityOnline(arg_4_0)
	local var_4_0 = arg_4_0:getActId()

	if not var_4_0 then
		return false
	end

	return ActivityModel.instance:isActOnLine(var_4_0)
end

function var_0_0.setActInfo(arg_5_0, arg_5_1)
	arg_5_0:getActMo(arg_5_1.activityId):updateInfo(arg_5_1)
end

function var_0_0.getActMo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	if not var_6_0 then
		var_6_0 = Activity186MO.New()

		var_6_0:init(arg_6_1)
		arg_6_0:addAtLast(var_6_0)
	end

	return var_6_0
end

function var_0_0.onFinishAct186Task(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getById(arg_7_1.activityId)

	if var_7_0 then
		var_7_0:finishTask(arg_7_1.taskId)
	end
end

function var_0_0.onGetAct186MilestoneReward(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getById(arg_8_1.activityId)

	if var_8_0 then
		var_8_0:acceptRewards(arg_8_1.getMilestoneProgress)
	end
end

function var_0_0.onGetAct186DailyCollection(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getById(arg_9_1.activityId)

	if var_9_0 then
		var_9_0:onGetDailyCollection()
	end
end

function var_0_0.onAct186TaskPush(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getById(arg_10_1.activityId)

	if var_10_0 then
		var_10_0:pushTask(arg_10_1.act186Tasks, arg_10_1.deleteTasks)
	end
end

function var_0_0.onAct186LikePush(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getById(arg_11_1.activityId)

	if var_11_0 then
		var_11_0:pushLike(arg_11_1.likeInfos)
	end
end

function var_0_0.onFinishAct186Game(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getById(arg_12_1.activityId)

	if var_12_0 then
		var_12_0:finishGame(arg_12_1)
	end
end

function var_0_0.onBTypeGamePlay(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getById(arg_13_1.activityId)

	if var_13_0 then
		var_13_0:playBTypeGame(arg_13_1)
	end
end

function var_0_0.onGetAct186SpBonusInfo(arg_14_0, arg_14_1)
	arg_14_0:getActMo(arg_14_1.act186ActivityId):setSpBonusStage(arg_14_1.spBonusStage)
end

function var_0_0.onAcceptAct186SpBonus(arg_15_0, arg_15_1)
	arg_15_0:getActMo(arg_15_1.act186ActivityId):setSpBonusStage(2)
end

function var_0_0.onGetOnceBonusReply(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getById(arg_16_1.activityId)

	if var_16_0 then
		var_16_0:onGetOnceBonus(arg_16_1)
	end
end

function var_0_0.getLocalPrefsTab(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:prefabKeyPrefs(arg_17_1, arg_17_2)

	if not arg_17_0.localPrefsDict[var_17_0] then
		local var_17_1 = {}
		local var_17_2 = Activity186Controller.instance:getPlayerPrefs(var_17_0)
		local var_17_3 = GameUtil.splitString2(var_17_2, true)

		if var_17_3 then
			for iter_17_0, iter_17_1 in ipairs(var_17_3) do
				var_17_1[iter_17_1[1]] = iter_17_1[2]
			end
		end

		arg_17_0.localPrefsDict[var_17_0] = var_17_1
	end

	return arg_17_0.localPrefsDict[var_17_0]
end

function var_0_0.getLocalPrefsState(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	return arg_18_0:getLocalPrefsTab(arg_18_1, arg_18_2)[arg_18_3] or arg_18_4
end

function var_0_0.setLocalPrefsState(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = arg_19_0:getLocalPrefsTab(arg_19_1, arg_19_2)

	if var_19_0[arg_19_3] == arg_19_4 then
		return
	end

	var_19_0[arg_19_3] = arg_19_4

	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		table.insert(var_19_1, string.format("%s#%s", iter_19_0, iter_19_1))
	end

	local var_19_2 = table.concat(var_19_1, "|")
	local var_19_3 = arg_19_0:prefabKeyPrefs(arg_19_1, arg_19_2)

	Activity186Controller.instance:setPlayerPrefs(var_19_3, var_19_2)
end

function var_0_0.prefabKeyPrefs(arg_20_0, arg_20_1, arg_20_2)
	if string.nilorempty(arg_20_1) then
		return arg_20_1
	end

	return (string.format("%s_%s", arg_20_1, arg_20_2))
end

function var_0_0.checkReadTasks(arg_21_0, arg_21_1)
	if arg_21_1 then
		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			arg_21_0:checkReadTask(iter_21_1)
		end
	end
end

function var_0_0.checkReadTask(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	local var_22_0 = arg_22_0:getActMo(arg_22_0:getActId())

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0:getTaskInfo(arg_22_1)

	if not var_22_1 then
		return
	end

	if var_22_1.hasGetBonus then
		return
	end

	if var_22_0:checkTaskCanReward(var_22_1) then
		return
	end

	TaskRpc.instance:sendFinishReadTaskRequest(arg_22_1)
end

function var_0_0.isShowSignRed(arg_23_0)
	local var_23_0 = ActivityEnum.Activity.V2a5_Act186Sign

	if ActivityHelper.getActivityStatus(var_23_0) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local var_23_1 = false
	local var_23_2 = arg_23_0:getActId()
	local var_23_3 = arg_23_0:getById(var_23_2)

	if var_23_3 then
		var_23_1 = var_23_3.spBonusStage == 1
	end

	var_23_1 = var_23_1 or ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_23_0)

	return var_23_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
