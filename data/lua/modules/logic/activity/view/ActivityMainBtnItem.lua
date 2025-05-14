module("modules.logic.activity.view.ActivityMainBtnItem", package.seeall)

local var_0_0 = class("ActivityMainBtnItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._centerId = arg_1_1
	arg_1_0._centerCo = ActivityConfig.instance:getActivityCenterCo(arg_1_1)
	arg_1_0.go = gohelper.cloneInPlace(arg_1_2)

	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._imgGo = gohelper.findChild(arg_1_0.go, "bg")
	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0.go, "bg")
	arg_1_0._btnitem = gohelper.getClick(arg_1_0._imgGo)

	arg_1_0:_initReddotitem(arg_1_0.go)

	arg_1_0._reddotitem = gohelper.findChild(arg_1_0.go, "go_activityreddot")

	arg_1_0:addEvent()
	arg_1_0:_refreshItem()
end

function var_0_0.addEvent(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvent(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Activity) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Activity))

		return
	end

	if arg_4_0._centerId == ActivityEnum.ActivityType.Normal then
		ActivityController.instance:openActivityNormalView()
	elseif arg_4_0._centerId == ActivityEnum.ActivityType.Beginner then
		ActivityRpc.instance:sendGetActivityInfosRequest(arg_4_0.openActivityBeginnerView, arg_4_0)
	elseif arg_4_0._centerId == ActivityEnum.ActivityType.Welfare then
		ActivityController.instance:openActivityWelfareView()
	end
end

function var_0_0.openActivityBeginnerView(arg_5_0)
	ActivityController.instance:openActivityBeginnerView()
end

function var_0_0._refreshItem(arg_6_0)
	local var_6_0 = ActivityModel.showActivityEffect()
	local var_6_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_6_2 = var_6_0 and var_6_1.mainViewActBtnPrefix .. arg_6_0._centerCo.icon or arg_6_0._centerCo.icon

	UISpriteSetMgr.instance:setMainSprite(arg_6_0._imgitem, var_6_2, true)

	if not var_6_0 then
		local var_6_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_6_3 then
			for iter_6_0, iter_6_1 in ipairs(var_6_3.mainViewActBtn) do
				local var_6_4 = gohelper.findChild(arg_6_0.go, iter_6_1)

				if var_6_4 then
					gohelper.setActive(var_6_4, var_6_0)
				end
			end
		end
	end

	arg_6_0._redDot:refreshDot()
end

function var_0_0._showRedDotType(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1.show = true

	local var_7_0 = ActivityConfig.instance:getActivityCo(arg_7_2).redDotId
	local var_7_1 = var_7_0 ~= 0 and RedDotConfig.instance:getRedDotCO(var_7_0).style or RedDotEnum.Style.Normal

	arg_7_1:showRedDot(var_7_1)
end

function var_0_0.getActivityShowRedDotData(arg_8_0, arg_8_1)
	local var_8_0 = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(arg_8_1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return (PlayerPrefsHelper.getString(var_8_0, ""))
end

function var_0_0.destroy(arg_9_0)
	arg_9_0:removeEvent()
	gohelper.destroy(arg_9_0.go)
	arg_9_0:__onDispose()
end

function var_0_0.getSortPriority(arg_10_0)
	return arg_10_0._centerCo.sortPriority
end

function var_0_0.isShowRedDot(arg_11_0)
	return arg_11_0._redDot.show
end

function var_0_0._initReddotitem(arg_12_0, arg_12_1)
	local var_12_0 = gohelper.findChild(arg_12_1, "go_activityreddot")
	local var_12_1 = tonumber(RedDotConfig.instance:getRedDotCO(arg_12_0._centerCo.reddotid).parent)

	if arg_12_0._centerCo.id == ActivityEnum.ActivityType.Welfare then
		arg_12_0._redDot = RedDotController.instance:addRedDot(var_12_0, var_12_1, false, arg_12_0._onRefreshDot_Welfare, arg_12_0)
	else
		arg_12_0._redDot = RedDotController.instance:addRedDot(var_12_0, var_12_1, false, arg_12_0._onRefreshDot_ActivityBeginner, arg_12_0)
	end

	do return end

	local var_12_2 = gohelper.findChild(arg_12_1, "go_activityreddot/#go_special_reds")
	local var_12_3 = var_12_2.transform
	local var_12_4 = var_12_3.childCount

	for iter_12_0 = 1, var_12_4 do
		local var_12_5 = var_12_3:GetChild(iter_12_0 - 1)

		gohelper.setActive(var_12_5.gameObject, false)
	end

	local var_12_6
	local var_12_7 = tonumber(RedDotConfig.instance:getRedDotCO(arg_12_0._centerCo.reddotid).parent)

	if arg_12_0._centerCo.id == ActivityEnum.ActivityType.Welfare then
		var_12_6 = gohelper.findChild(var_12_2, "#go_welfare_red")
		arg_12_0._redDot = RedDotController.instance:addRedDotTag(var_12_6, var_12_7, false, arg_12_0._onRefreshDot_Welfare, arg_12_0)
	else
		var_12_6 = gohelper.findChild(var_12_2, "#go_activity_beginner_red")
		arg_12_0._redDot = RedDotController.instance:addRedDotTag(var_12_6, var_12_7, false, arg_12_0._onRefreshDot_ActivityBeginner, arg_12_0)
	end

	arg_12_0._btnitem2 = gohelper.getClick(var_12_6)
end

function var_0_0._onRefreshDot_Welfare(arg_13_0, arg_13_1)
	arg_13_0._curActId = nil

	local var_13_0, var_13_1 = pcall(arg_13_1.dotId and arg_13_0._checkRed_Welfare or arg_13_0._checkActivityWelfareRedDot, arg_13_0, arg_13_1)

	if not var_13_0 then
		logError(string.format("ActivityMainBtnItem:_checkRed_Welfare actId:%s error:%s", arg_13_0._curActId, var_13_1))
	end
end

function var_0_0._onRefreshDot_ActivityBeginner(arg_14_0, arg_14_1)
	arg_14_0._curActId = nil

	local var_14_0, var_14_1 = pcall(arg_14_1.dotId and arg_14_0._checkRed_ActivityBeginner or arg_14_0._checkActivityShowRedDotData, arg_14_0, arg_14_1)

	if not var_14_0 then
		logError(string.format("ActivityMainBtnItem:_checkRed_ActivityBeginner actId:%s error:%s", arg_14_0._curActId, var_14_1))
	end
end

function var_0_0._checkRed_ActivityBeginner(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:_checkIsShowRed_ActivityBeginner(arg_15_1.dotId, 0)

	arg_15_1.show = var_15_0

	gohelper.setActive(arg_15_1.go, var_15_0)
	gohelper.setActive(arg_15_0._imgGo, not var_15_0)
end

function var_0_0._checkRed_Welfare(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:_checkIsShowRed_Welfare(arg_16_1.dotId, 0)

	arg_16_1.show = var_16_0

	gohelper.setActive(arg_16_1.go, var_16_0)
	gohelper.setActive(arg_16_0._imgGo, not var_16_0)
end

function var_0_0._checkIsShowRed_Welfare(arg_17_0, arg_17_1, arg_17_2)
	if RedDotModel.instance:isDotShow(arg_17_1, arg_17_2 or 0) then
		return true
	end

	local var_17_0 = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		arg_17_0._curActId = iter_17_1

		if iter_17_1 == ActivityEnum.Activity.StoryShow and not TaskModel.instance:isFinishAllNoviceTask() and string.nilorempty(arg_17_0:getActivityShowRedDotData(iter_17_1)) then
			return true
		end

		if iter_17_1 == ActivityEnum.Activity.ClassShow and not TeachNoteModel.instance:isFinalRewardGet() and string.nilorempty(arg_17_0:getActivityShowRedDotData(iter_17_1)) then
			return true
		end
	end

	return false
end

function var_0_0._checkIsShowRed_ActivityBeginner(arg_18_0, arg_18_1, arg_18_2)
	if RedDotModel.instance:isDotShow(arg_18_1, arg_18_2 or 0) then
		return true
	end

	local var_18_0 = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		arg_18_0._curActId = iter_18_1

		if iter_18_1 == DoubleDropModel.instance:getActId() and string.nilorempty(arg_18_0:getActivityShowRedDotData(iter_18_1)) then
			return true
		end

		if iter_18_1 == ActivityEnum.Activity.DreamShow then
			local var_18_1 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow)
			local var_18_2 = var_18_1 and var_18_1[1]

			if var_18_2 and var_18_2.config and var_18_2.finishCount < var_18_2.config.maxFinishCount and string.nilorempty(arg_18_0:getActivityShowRedDotData(iter_18_1)) then
				return true
			end
		end

		if iter_18_1 == ActivityEnum.Activity.Activity1_7WarmUp and Activity125Controller.instance:checkActRed(iter_18_1) then
			return true
		end

		if iter_18_1 == ActivityEnum.Activity.Activity1_8WarmUp and Activity125Controller.instance:checkActRed1(iter_18_1) then
			return true
		end

		if (iter_18_1 == ActivityEnum.Activity.Activity1_9WarmUp or iter_18_1 == ActivityEnum.Activity.V2a0_WarmUp or iter_18_1 == ActivityEnum.Activity.V2a1_WarmUp or iter_18_1 == ActivityEnum.Activity.V2a2_WarmUp or iter_18_1 == ActivityEnum.Activity.V2a3_WarmUp or iter_18_1 == ActivityEnum.Activity.V2a5_WarmUp) and Activity125Controller.instance:checkActRed2(iter_18_1) then
			return true
		end

		if iter_18_1 == ActivityEnum.Activity.Activity1_5WarmUp and Activity146Controller.instance:isActFirstEnterToday() and (not Activity146Model.instance:isAllEpisodeFinish() or Activity146Model.instance:isHasEpisodeCanReceiveReward()) then
			return true
		end

		if iter_18_1 == ActivityEnum.Activity.V2a2_TurnBack_H5 and ActivityBeginnerController.instance:checkFirstEnter(iter_18_1) then
			return true
		end

		if iter_18_1 == VersionActivity2_2Enum.ActivityId.LimitDecorate and ActivityBeginnerController.instance:checkFirstEnter(iter_18_1) then
			return true
		end

		if typeId == ActivityEnum.ActivityTypeID.Act125 and Activity125Controller.instance:checkActRed2(iter_18_1) then
			return true
		end

		if typeId == ActivityEnum.ActivityTypeID.Act201 and ActivityBeginnerController.instance:checkFirstEnter(iter_18_1) then
			return true
		end
	end

	return false
end

function var_0_0._checkActivityShowRedDotData(arg_19_0, arg_19_1)
	arg_19_1:defaultRefreshDot()

	if not arg_19_1.show then
		local var_19_0 = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)

		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			local var_19_1 = ActivityConfig.instance:getActivityCo(iter_19_1).typeId

			arg_19_0._curActId = iter_19_1

			if iter_19_1 == VoyageConfig.instance:getActivityId() and string.nilorempty(arg_19_0:getActivityShowRedDotData(iter_19_1)) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == DoubleDropModel.instance:getActId() and string.nilorempty(arg_19_0:getActivityShowRedDotData(iter_19_1)) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == ActivityEnum.Activity.DreamShow then
				local var_19_2 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow)
				local var_19_3 = var_19_2 and var_19_2[1]

				if var_19_3 and var_19_3.config and var_19_3.finishCount < var_19_3.config.maxFinishCount and string.nilorempty(arg_19_0:getActivityShowRedDotData(iter_19_1)) then
					arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

					return
				end
			end

			if iter_19_1 == ActivityEnum.Activity.WeekWalkDeepShow and ActivityModel.instance:getActivityInfo()[iter_19_1]:isNewStageOpen() then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == ActivityEnum.Activity.Activity1_7WarmUp and Activity125Controller.instance:checkActRed(iter_19_1) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == ActivityEnum.Activity.Activity1_8WarmUp and Activity125Controller.instance:checkActRed1(iter_19_1) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if (iter_19_1 == ActivityEnum.Activity.Activity1_9WarmUp or iter_19_1 == ActivityEnum.Activity.V2a0_WarmUp or iter_19_1 == ActivityEnum.Activity.V2a1_WarmUp or iter_19_1 == ActivityEnum.Activity.V2a2_WarmUp or iter_19_1 == ActivityEnum.Activity.V2a3_WarmUp or iter_19_1 == ActivityEnum.Activity.V2a5_WarmUp) and Activity125Controller.instance:checkActRed2(iter_19_1) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == ActivityEnum.Activity.Activity1_5WarmUp and Activity146Controller.instance:isActFirstEnterToday() and (not Activity146Model.instance:isAllEpisodeFinish() or Activity146Model.instance:isHasEpisodeCanReceiveReward()) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == ActivityEnum.Activity.V2a2_TurnBack_H5 and ActivityBeginnerController.instance:checkFirstEnter(iter_19_1) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == VersionActivity2_2Enum.ActivityId.LimitDecorate and ActivityBeginnerController.instance:checkFirstEnter(iter_19_1) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if iter_19_1 == ActivityEnum.Activity.V2a4_WarmUp and Activity125Controller.instance:checkActRed3(iter_19_1) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end

			if var_19_1 == ActivityEnum.ActivityTypeID.Act201 and ActivityBeginnerController.instance:checkFirstEnter(iter_19_1) then
				arg_19_0:_showRedDotType(arg_19_1, iter_19_1)

				return
			end
		end
	end
end

function var_0_0._checkActivityWelfareRedDot(arg_20_0, arg_20_1)
	arg_20_1:defaultRefreshDot()

	if not arg_20_1.show then
		local var_20_0 = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			arg_20_0._curActId = iter_20_1

			if iter_20_1 == ActivityEnum.Activity.StoryShow and not TaskModel.instance:isFinishAllNoviceTask() and string.nilorempty(arg_20_0:getActivityShowRedDotData(iter_20_1)) then
				arg_20_0:_showRedDotType(arg_20_1, iter_20_1)

				return
			end

			if iter_20_1 == ActivityEnum.Activity.ClassShow and not TeachNoteModel.instance:isFinalRewardGet() and string.nilorempty(arg_20_0:getActivityShowRedDotData(iter_20_1)) then
				arg_20_0:_showRedDotType(arg_20_1, iter_20_1)

				return
			end
		end
	end
end

return var_0_0
