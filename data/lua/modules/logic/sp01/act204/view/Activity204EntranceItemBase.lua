module("modules.logic.sp01.act204.view.Activity204EntranceItemBase", package.seeall)

local var_0_0 = class("Activity204EntranceItemBase", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._btnEntrance = gohelper.findChildButtonWithAudio(arg_1_0.go, "root/#btn_Entrance")
	arg_1_0._txtEntrance = gohelper.findChildText(arg_1_0.go, "root/#btn_Entrance/txt_Entrance")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.go, "root/LimitTime/#txt_Time")
	arg_1_0._goRedPoint = gohelper.findChild(arg_1_0.go, "root/#go_RedPoint")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.go, "root/#go_Locked")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.go, "root/#go_Finished")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.go, "root/#go_unlock")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnEntrance:AddClickListener(arg_2_0._btnEntranceOnClick, arg_2_0)
end

function var_0_0._btnEntranceOnClick(arg_3_0)
	local var_3_0, var_3_1, var_3_2 = arg_3_0:_getActivityStatus()

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_3_1 then
			GameFacade.showToastWithTableParam(var_3_1, var_3_2)
		end

		return
	end

	Activity204Controller.instance:jumpToActivity(arg_3_0._actId)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnEntrance:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0:initActInfo(arg_5_1)
	arg_5_0:refreshUI()
	arg_5_0:updateReddot()
	TaskDispatcher.cancelTask(arg_5_0.refreshUI, arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0.refreshUI, arg_5_0, 1)
end

function var_0_0.initActInfo(arg_6_0, arg_6_1)
	arg_6_0._actId = arg_6_1
	arg_6_0._actCfg = ActivityConfig.instance:getActivityCo(arg_6_1)
	arg_6_0._actMo = ActivityModel.instance:getActMO(arg_6_1)
	arg_6_0._startTime = arg_6_0._actMo:getRealStartTimeStamp()
	arg_6_0._endTime = arg_6_0._actMo:getRealEndTimeStamp()
end

function var_0_0.refreshUI(arg_7_0)
	if not arg_7_0._actCfg then
		TaskDispatcher.cancelTask(arg_7_0.refreshUI, arg_7_0)

		return
	end

	arg_7_0:updateStatus()
	arg_7_0:refreshTitle()
	arg_7_0:updateRemainTime()
end

function var_0_0.refreshTitle(arg_8_0)
	arg_8_0._txtEntrance.text = arg_8_0._actCfg and arg_8_0._actCfg.tabName or ""
end

function var_0_0.updateStatus(arg_9_0)
	arg_9_0._status = arg_9_0:_getActivityStatus()
	arg_9_0._isFinish = arg_9_0._status == ActivityEnum.ActivityStatus.Expired or arg_9_0._status == ActivityEnum.ActivityStatus.NotOnLine

	gohelper.setActive(arg_9_0._golocked, arg_9_0._status == ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(arg_9_0._gofinished, arg_9_0._isFinish)
end

function var_0_0._getActivityStatus(arg_10_0)
	return ActivityHelper.getActivityStatusAndToast(arg_10_0._actId)
end

function var_0_0.updateRemainTime(arg_11_0)
	local var_11_0 = arg_11_0:_getTimeStr()

	arg_11_0._txtTime.text = var_11_0 or ""
end

function var_0_0._getTimeStr(arg_12_0)
	if not arg_12_0._actMo then
		return
	end

	local var_12_0 = arg_12_0:_getActivityStatus()

	return arg_12_0:_decorateTimeStr(var_12_0, arg_12_0._startTime, arg_12_0._endTime)
end

function var_0_0._decorateTimeStr(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_2 or not arg_13_3 then
		return
	end

	local var_13_0 = ServerTime.now()
	local var_13_1 = ""

	if arg_13_1 == ActivityEnum.ActivityStatus.NotOpen then
		local var_13_2 = arg_13_2 - var_13_0

		var_13_1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_lock"), TimeUtil.SecondToActivityTimeFormat(var_13_2))
	elseif arg_13_1 == ActivityEnum.ActivityStatus.NotUnlock then
		if arg_13_0._actCfg.openId ~= 0 then
			var_13_1 = OpenHelper.getActivityUnlockTxt(arg_13_0._actCfg.openId)
		end
	elseif arg_13_1 == ActivityEnum.ActivityStatus.Normal then
		local var_13_3 = arg_13_3 - var_13_0

		if var_13_3 > 0 then
			var_13_1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_open"), TimeUtil.SecondToActivityTimeFormat(var_13_3))
		else
			var_13_1 = luaLang("turnback_end")
		end
	else
		var_13_1 = luaLang("turnback_end")
	end

	return var_13_1
end

function var_0_0.updateReddot(arg_14_0)
	if arg_14_0._actCfg and arg_14_0._actCfg.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_14_0._goRedPoint, arg_14_0._actCfg.redDotId)
	end
end

function var_0_0.onDestroy(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.refreshUI, arg_15_0)
end

return var_0_0
