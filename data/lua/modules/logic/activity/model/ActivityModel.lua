module("modules.logic.activity.model.ActivityModel", package.seeall)

local var_0_0 = class("ActivityModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfo = {}
	arg_2_0._finishActTab = {}
	arg_2_0._actMoTab = {}
	arg_2_0._isNoviceTaskUnlock = false
	arg_2_0._targetActivityCategoryId = 0
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	arg_3_0._actInfo = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.activityInfos) do
		if ActivityConfig.instance:getActivityCo(iter_3_1.id) then
			local var_3_0 = ActivityInfoMo.New()

			var_3_0:init(iter_3_1)

			arg_3_0._actInfo[iter_3_1.id] = var_3_0
		end
	end
end

function var_0_0.updateActivityInfo(arg_4_0, arg_4_1)
	local var_4_0 = ActivityInfoMo.New()

	var_4_0:init(arg_4_1)

	arg_4_0._actInfo[arg_4_1.id] = var_4_0
end

function var_0_0.updateInfoNoRepleace(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._actInfo[arg_5_1.id]

	if not var_5_0 then
		var_5_0 = ActivityInfoMo.New()
		arg_5_0._actInfo[arg_5_1.id] = var_5_0
	end

	var_5_0:init(arg_5_1)
end

function var_0_0.endActivity(arg_6_0, arg_6_1)
	if arg_6_0._actInfo[arg_6_1] then
		arg_6_0._actInfo[arg_6_1].online = false
	end
end

function var_0_0.getActivityInfo(arg_7_0)
	return arg_7_0._actInfo
end

function var_0_0.getActMO(arg_8_0, arg_8_1)
	return arg_8_0._actInfo[arg_8_1]
end

function var_0_0.isActOnLine(arg_9_0, arg_9_1)
	return arg_9_0._actInfo[arg_9_1] and arg_9_0._actInfo[arg_9_1].online
end

function var_0_0.getOnlineActIdByType(arg_10_0, arg_10_1)
	local var_10_0

	for iter_10_0, iter_10_1 in pairs(arg_10_0._actInfo) do
		if iter_10_1.actType == arg_10_1 and iter_10_1.online then
			var_10_0 = var_10_0 or {}

			table.insert(var_10_0, iter_10_0)
		end
	end

	return var_10_0
end

function var_0_0.getActStartTime(arg_11_0, arg_11_1)
	return arg_11_0._actInfo[arg_11_1].startTime
end

function var_0_0.getActEndTime(arg_12_0, arg_12_1)
	return arg_12_0._actInfo[arg_12_1].endTime
end

function var_0_0.hasActivityUnlock(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._actInfo) do
		if iter_13_1.online then
			return true
		end
	end

	return false
end

function var_0_0.getTargetActivityCategoryId(arg_14_0, arg_14_1)
	if not next(arg_14_0._actInfo) then
		arg_14_0._targetActivityCategoryId = 0

		return 0
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0._actInfo) do
		if iter_14_1.id == arg_14_0._targetActivityCategoryId and iter_14_1.centerId == arg_14_1 and iter_14_1.online then
			return arg_14_0._targetActivityCategoryId
		end
	end

	local var_14_0 = {}

	for iter_14_2, iter_14_3 in pairs(arg_14_0._actInfo) do
		if iter_14_3.centerId == arg_14_1 and iter_14_3.online then
			table.insert(var_14_0, iter_14_3.id)

			arg_14_0._actMoTab[iter_14_3.id] = iter_14_3
		end
	end

	local var_14_1 = arg_14_0:removeUnExitAct(var_14_0)

	table.sort(var_14_1, function(arg_15_0, arg_15_1)
		return ActivityConfig.instance:getActivityCo(arg_15_0).displayPriority < ActivityConfig.instance:getActivityCo(arg_15_1).displayPriority
	end)

	arg_14_0._targetActivityCategoryId = #var_14_1 > 0 and var_14_1[1] or 0

	return arg_14_0._targetActivityCategoryId
end

function var_0_0.setTargetActivityCategoryId(arg_16_0, arg_16_1)
	arg_16_0._targetActivityCategoryId = arg_16_1
end

function var_0_0.getCurTargetActivityCategoryId(arg_17_0)
	return arg_17_0._targetActivityCategoryId
end

function var_0_0.addFinishActivity(arg_18_0, arg_18_1)
	arg_18_0._finishActTab[arg_18_1] = arg_18_1
end

function var_0_0.removeUnExitAct(arg_19_0, arg_19_1)
	if GameUtil.getTabLen(arg_19_1) == 0 then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0._finishActTab) do
		tabletool.removeValue(arg_19_1, iter_19_1)
	end

	return arg_19_1
end

function var_0_0.getActivityCenter(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0._actInfo) do
		if iter_20_1.centerId ~= 0 and iter_20_1.online then
			if not var_20_0[iter_20_1.centerId] then
				var_20_0[iter_20_1.centerId] = {}
			end

			table.insert(var_20_0[iter_20_1.centerId], iter_20_1.id)
		end
	end

	return var_20_0
end

function var_0_0.getCenterActivities(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0._actInfo) do
		if iter_21_1.centerId == arg_21_1 and iter_21_1.online then
			table.insert(var_21_0, iter_21_1.id)
		end
	end

	return var_21_0
end

function var_0_0.hasNorSignRewardUnReceived(arg_22_0)
	local var_22_0 = ActivityType101Model.instance:getType101Info(ActivityEnum.Activity.NorSign)

	if var_22_0 then
		for iter_22_0, iter_22_1 in pairs(var_22_0) do
			if iter_22_1.state == 1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasNoviceSignRewardUnReceived(arg_23_0)
	local var_23_0 = ActivityType101Model.instance:getType101Info(ActivityEnum.Activity.NoviceSign)

	if var_23_0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			if iter_23_1.state == 1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getRemainTime(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getActMO(arg_24_1)

	if var_24_0 then
		local var_24_1 = var_24_0.endTime / 1000 - ServerTime.now()
		local var_24_2 = Mathf.Floor(var_24_1 / TimeUtil.OneDaySecond)
		local var_24_3 = var_24_1 % TimeUtil.OneDaySecond
		local var_24_4 = Mathf.Floor(var_24_3 / TimeUtil.OneHourSecond)
		local var_24_5 = var_24_3 % TimeUtil.OneHourSecond
		local var_24_6 = Mathf.Ceil(var_24_5 / TimeUtil.OneMinuteSecond)

		return var_24_2, var_24_4, var_24_6
	end
end

function var_0_0.removeFinishedCategory(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_1) do
		if iter_25_1 == ActivityEnum.Activity.DreamShow then
			local var_25_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.ActivityShow)

			if var_25_0 and next(var_25_0) then
				local var_25_1 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow)

				if var_25_1 and var_25_1[1].finishCount >= var_25_1[1].config.maxFinishCount then
					arg_25_1[iter_25_0] = nil

					arg_25_0:addFinishActivity(iter_25_1)
				end
			end
		elseif iter_25_1 == ActivityEnum.Activity.V2a7_SelfSelectSix1 and ActivityType101Model.instance:isType101RewardGet(iter_25_1, 1) then
			arg_25_1[iter_25_0] = nil

			arg_25_0:addFinishActivity(iter_25_1)
		end
	end
end

function var_0_0.removeFinishedWelfare(arg_26_0, arg_26_1)
	local var_26_0 = false
	local var_26_1 = ActivityType101Model.instance:hasReceiveAllReward(ActivityEnum.Activity.NoviceSign)
	local var_26_2 = TeachNoteModel.instance:isFinalRewardGet()
	local var_26_3 = Activity160Model.instance:allRewardReceive(ActivityEnum.Activity.NewWelfare)

	for iter_26_0, iter_26_1 in pairs(arg_26_1) do
		if iter_26_1 == ActivityEnum.Activity.StoryShow and TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
			local var_26_4 = true

			arg_26_1[iter_26_0] = nil

			arg_26_0:addFinishActivity(iter_26_1)
		end

		if iter_26_1 == ActivityEnum.Activity.ClassShow and var_26_2 then
			arg_26_1[iter_26_0] = nil

			arg_26_0:addFinishActivity(iter_26_1)
		end

		if iter_26_1 == ActivityEnum.Activity.NoviceSign and var_26_1 then
			arg_26_1[iter_26_0] = nil

			arg_26_0:addFinishActivity(iter_26_1)
		end

		if iter_26_1 == ActivityEnum.Activity.NewWelfare and var_26_3 then
			arg_26_1[iter_26_0] = nil

			arg_26_0:addFinishActivity(ActivityEnum.Activity.NewWelfare)
		end
	end
end

function var_0_0.removeSelectSixAfterRemoveFinished(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_1) do
		if iter_27_1 == ActivityEnum.Activity.V2a7_SelfSelectSix2 and ActivityType101Model.instance:isType101RewardGet(iter_27_1, 1) then
			arg_27_1[iter_27_0] = nil
		end
	end
end

function var_0_0.getRemainTimeSec(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getActMO(arg_28_1)

	if var_28_0 then
		return var_28_0.endTime / 1000 - ServerTime.now()
	end
end

function var_0_0.setPermanentUnlock(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getActMO(arg_29_1)

	if var_29_0 then
		var_29_0:setPermanentUnlock()
	end
end

function var_0_0.isReceiveAllBonus(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getActMO(arg_30_1)

	if var_30_0 then
		return var_30_0.isReceiveAllBonus
	end

	return false
end

function var_0_0.checkIsShowLogoVisible()
	local var_31_0 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if not var_31_0 then
		return false
	end

	return var_31_0.isShowLogo or false
end

function var_0_0.checkIsShowActBgVisible()
	local var_32_0 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if not var_32_0 then
		return false
	end

	return var_32_0.isShowActBg or false
end

function var_0_0.checkIsShowFxVisible()
	local var_33_0 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if not var_33_0 then
		return false
	end

	return var_33_0.isShowFx or false
end

function var_0_0.showActivityEffect()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon) then
		return false
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		return false
	end

	local var_34_0 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if not var_34_0 then
		return false
	end

	local var_34_1 = var_34_0.id
	local var_34_2 = ActivityHelper.getActivityStatus(var_34_1)

	if var_34_2 == ActivityEnum.ActivityStatus.Normal or var_34_2 == ActivityEnum.ActivityStatus.NotUnlock then
		return true
	end

	return false
end

function var_0_0.tryGetFirstOpenedActCOByTypeId(arg_35_0, arg_35_1)
	local var_35_0 = ActivityConfig.instance:typeId2ActivityCOList(arg_35_1)

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		local var_35_1 = iter_35_1.id

		if ActivityHelper.getActivityStatus(var_35_1, true) == ActivityEnum.ActivityStatus.Normal then
			return iter_35_1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
