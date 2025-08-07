module("modules.logic.sp01.act204.view.Activity204OceanEntranceItem", package.seeall)

local var_0_0 = class("Activity204OceanEntranceItem", Activity204EntranceItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gounlockeffect = gohelper.findChild(arg_1_0.go, "root/#saoguang")
	arg_1_0._gobg1 = gohelper.findChild(arg_1_0.go, "root/#btn_Entrance/go_bg1")
	arg_1_0._gobg2 = gohelper.findChild(arg_1_0.go, "root/#btn_Entrance/go_bg2")

	gohelper.setActive(arg_1_0._gounlockeffect, false)
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.initActInfo(arg_3_0, arg_3_1)
	var_0_0.super.initActInfo(arg_3_0, arg_3_1)
	arg_3_0:_initStageList(arg_3_1)
end

function var_0_0._getActivityStatus(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = arg_4_0:_getCurShowStage()

	if var_4_1 == ActivityEnum.ActivityStatus.Expired then
		logNormal(arg_4_0._actId .. "活动不满足开放时间: " .. TimeUtil.timestampToString(arg_4_0._startTime) .. "," .. TimeUtil.timestampToString(arg_4_0._endTime))
	end

	return var_4_1, var_4_2
end

function var_0_0.refreshTitle(arg_5_0)
	local var_5_0, var_5_1 = arg_5_0:_getCurShowStage()
	local var_5_2 = var_5_0 and var_5_0.config

	arg_5_0._txtEntrance.text = var_5_2 and var_5_2.name or ""
	arg_5_0._isCardGameOpen = var_5_0 and var_5_0.stageId == Act205Enum.GameStageId.Card and var_5_1 == ActivityEnum.ActivityStatus.Normal

	if arg_5_0._isCardGameOpen and arg_5_0._isCardGameNewOpen == nil then
		arg_5_0._isCardGameNewOpen = Activity204Controller.instance:getPlayerPrefs(PlayerPrefsKey.Activity204CardNewUnlockEffect, 0) == 0

		arg_5_0:tryPlayNewUnlockEffect()
	end

	gohelper.setActive(arg_5_0._gobg1, var_5_0.stageId == Act205Enum.GameStageId.Card)
	gohelper.setActive(arg_5_0._gobg2, var_5_0.stageId == Act205Enum.GameStageId.Ocean)
end

function var_0_0._onOpenViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 ~= ViewName.Activity204EntranceView then
		return
	end

	arg_6_0:tryPlayNewUnlockEffect()
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.Activity204EntranceView then
		return
	end

	arg_7_0:tryPlayNewUnlockEffect()
end

function var_0_0.tryPlayNewUnlockEffect(arg_8_0)
	if not arg_8_0._isCardGameNewOpen or ViewMgr.instance:isOpening(ViewName.Activity204EntranceView) or not ViewHelper.instance:checkViewOnTheTop(ViewName.Activity204EntranceView) then
		return
	end

	arg_8_0._isCardGameNewOpen = false

	gohelper.setActive(arg_8_0._gounlockeffect, true)
	Activity204Controller.instance:setPlayerPrefs(PlayerPrefsKey.Activity204CardNewUnlockEffect, 1)
end

function var_0_0._getTimeStr(arg_9_0)
	if not arg_9_0._actMo then
		return
	end

	local var_9_0, var_9_1 = arg_9_0:_getCurShowStage()
	local var_9_2 = var_9_0 and var_9_0.startTime
	local var_9_3 = var_9_0 and var_9_0.endTime

	return arg_9_0:_decorateTimeStr(var_9_1, var_9_2, var_9_3)
end

function var_0_0._initStageList(arg_10_0, arg_10_1)
	local var_10_0 = lua_actvity205_stage.configDict[arg_10_1]

	arg_10_0._stageMoList = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = {
			config = iter_10_1,
			stageId = iter_10_1.stageId,
			activityId = iter_10_1.activityId
		}

		var_10_1.activityCofig = ActivityConfig.instance:getActivityCo(var_10_1.activityId)
		var_10_1.startTime = Act205Config.instance:getGameStageOpenTimeStamp(iter_10_1.activityId, iter_10_1.stageId)
		var_10_1.endTime = Act205Config.instance:getGameStageEndTimeStamp(iter_10_1.activityId, iter_10_1.stageId)

		table.insert(arg_10_0._stageMoList, var_10_1)
	end

	arg_10_0._stageCount = arg_10_0._stageMoList and #arg_10_0._stageMoList or 0

	table.sort(arg_10_0._stageMoList, arg_10_0._stageMoSortFunc)
end

function var_0_0._stageMoSortFunc(arg_11_0, arg_11_1)
	if arg_11_0.startTime ~= arg_11_1.startTime then
		return arg_11_0.startTime < arg_11_1.startTime
	end

	if arg_11_0.endTime ~= arg_11_1.endTime then
		return arg_11_0.endTime < arg_11_1.endTime
	end

	if arg_11_0.activityId ~= arg_11_1.activityId then
		return arg_11_0.activityId < arg_11_1.activityId
	end

	return arg_11_0.stageId ~= arg_11_1.stageId
end

function var_0_0._getStageStatus(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0, var_12_1, var_12_2 = ActivityHelper.getActivityStatusAndToast(arg_12_1.activityId)

	if var_12_0 ~= ActivityEnum.ActivityStatus.Normal then
		return var_12_0, var_12_1, var_12_2
	end

	local var_12_3 = ServerTime.now()

	if var_12_3 <= arg_12_1.startTime then
		return ActivityEnum.ActivityStatus.NotOpen, ToastEnum.ActivityNotOpen
	end

	if var_12_3 >= arg_12_1.endTime then
		return ActivityEnum.ActivityStatus.Expired, ToastEnum.ActivityEnd
	end

	return ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getCurShowStage(arg_13_0)
	local var_13_0
	local var_13_1
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._stageMoList) do
		local var_13_3, var_13_4 = arg_13_0:_getStageStatus(iter_13_1)

		var_13_0 = iter_13_1
		var_13_1 = var_13_3
		var_13_2 = var_13_4

		if var_13_3 == ActivityEnum.ActivityStatus.NotOpen or var_13_3 == ActivityEnum.ActivityStatus.Normal then
			break
		end
	end

	return var_13_0, var_13_1, var_13_2
end

function var_0_0.updateReddot(arg_14_0)
	if arg_14_0._actCfg and arg_14_0._actCfg.redDotId ~= 0 then
		local var_14_0 = {}

		table.insert(var_14_0, {
			id = RedDotEnum.DotNode.V2a9_Act205OceanOpen
		})
		table.insert(var_14_0, {
			id = arg_14_0._actCfg.redDotId
		})
		RedDotController.instance:addMultiRedDot(arg_14_0._goRedPoint, var_14_0)
	end
end

return var_0_0
