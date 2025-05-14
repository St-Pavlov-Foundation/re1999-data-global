module("modules.logic.versionactivity.view.VersionActivityExchangeTaskView", package.seeall)

local var_0_0 = class("VersionActivityExchangeTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._scrolltasklist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tasklist")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_tasklist/Viewport/Content/#go_taskitem")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._godailytask = gohelper.findChild(arg_1_0.viewGO, "option/#go_dailytask")
	arg_1_0._godailyselected = gohelper.findChild(arg_1_0.viewGO, "option/#go_dailytask/#go_daily_selected")
	arg_1_0._godailyunselected = gohelper.findChild(arg_1_0.viewGO, "option/#go_dailytask/#go_daily_unselected")
	arg_1_0._btndailyclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "option/#go_dailytask/#btn_daily_click")
	arg_1_0._gochallengetask = gohelper.findChild(arg_1_0.viewGO, "option/#go_challengetask")
	arg_1_0._gochallengeselected = gohelper.findChild(arg_1_0.viewGO, "option/#go_challengetask/#go_challenge_selected")
	arg_1_0._gochallengeunselected = gohelper.findChild(arg_1_0.viewGO, "option/#go_challengetask/#go_challenge_unselected")
	arg_1_0._btnchallengeclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "option/#go_challengetask/#btn_challenge_click")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#txt_remaintime")
	arg_1_0._gotaskdayreddot1 = gohelper.findChild(arg_1_0.viewGO, "option/#go_dailytask/#go_daily_selected/#go_taskdayreddot")
	arg_1_0._gotaskdayreddot2 = gohelper.findChild(arg_1_0.viewGO, "option/#go_dailytask/#go_daily_unselected/#go_taskdayreddot")
	arg_1_0._gotaskchallengereddot1 = gohelper.findChild(arg_1_0.viewGO, "option/#go_challengetask/#go_challenge_unselected/#go_taskchallengereddot")
	arg_1_0._gotaskchallengereddot2 = gohelper.findChild(arg_1_0.viewGO, "option/#go_challengetask/#go_challenge_selected/#go_taskchallengereddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
	arg_2_0._btndailyclick:AddClickListener(arg_2_0._btndailyclickOnClick, arg_2_0)
	arg_2_0._btnchallengeclick:AddClickListener(arg_2_0._btnchallengeclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
	arg_3_0._btndailyclick:RemoveClickListener()
	arg_3_0._btnchallengeclick:RemoveClickListener()
end

function var_0_0._btndailyclickOnClick(arg_4_0)
	arg_4_0._isDailyTaskType = true

	arg_4_0:_refreshTop()
	arg_4_0:_refreshTask()
end

function var_0_0._btnchallengeclickOnClick(arg_5_0)
	arg_5_0._isDailyTaskType = false

	arg_5_0:_refreshTop()
	arg_5_0:_refreshTask()
end

function var_0_0._btnclose1OnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.taskItemList = {}

	gohelper.setActive(arg_8_0._gotaskitem, false)
	RedDotController.instance:addRedDot(arg_8_0._gotaskdayreddot1, RedDotEnum.DotNode.VersionActivityExchangeTaskDay)
	RedDotController.instance:addRedDot(arg_8_0._gotaskdayreddot2, RedDotEnum.DotNode.VersionActivityExchangeTaskDay)
	RedDotController.instance:addRedDot(arg_8_0._gotaskchallengereddot1, RedDotEnum.DotNode.VersionActivityExchangeTaskChallenge)
	RedDotController.instance:addRedDot(arg_8_0._gotaskchallengereddot2, RedDotEnum.DotNode.VersionActivityExchangeTaskChallenge)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskGetBonus, arg_10_0.onGetBonus, arg_10_0)
	arg_10_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskUpdate, arg_10_0._refreshTask, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0.updateDeadline, arg_10_0, 60)

	arg_10_0._isDailyTaskType = true
	arg_10_0.actId = arg_10_0.viewParam.actId
	arg_10_0._actMO = ActivityModel.instance:getActMO(arg_10_0.actId)

	arg_10_0:_refreshTop()
	arg_10_0:_refreshTask(true)
	arg_10_0:updateDeadline()
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskGetBonus, arg_11_0.onGetBonus, arg_11_0)
	arg_11_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskUpdate, arg_11_0._refreshTask, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.updateDeadline, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.taskItemList) do
		iter_12_1:onDestroyView()
	end

	arg_12_0.taskItemList = nil
end

function var_0_0._refreshTop(arg_13_0)
	gohelper.setActive(arg_13_0._godailyselected, arg_13_0._isDailyTaskType)
	gohelper.setActive(arg_13_0._godailyunselected, arg_13_0._isDailyTaskType == false)
	gohelper.setActive(arg_13_0._gochallengeselected, arg_13_0._isDailyTaskType == false)
	gohelper.setActive(arg_13_0._gochallengeunselected, arg_13_0._isDailyTaskType)
end

function var_0_0._refreshTask(arg_14_0, arg_14_1)
	VersionActivity112TaskListModel.instance:updateTaksList(arg_14_0.actId, arg_14_0._isDailyTaskType)

	local var_14_0 = VersionActivity112TaskListModel.instance:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = arg_14_0.taskItemList[iter_14_0]

		if var_14_1 == nil then
			local var_14_2 = gohelper.cloneInPlace(arg_14_0._gotaskitem, "item" .. iter_14_0)

			gohelper.setActive(var_14_2, true)

			var_14_1 = MonoHelper.addLuaComOnceToGo(var_14_2, VersionActivityExchangeTaskItem, arg_14_0)
			arg_14_0.taskItemList[iter_14_0] = var_14_1
		end

		var_14_1:onUpdateMO(iter_14_1, iter_14_0, arg_14_1)
		gohelper.setActive(var_14_1.go, true)
	end

	for iter_14_2 = #var_14_0 + 1, #arg_14_0.taskItemList do
		gohelper.setActive(arg_14_0.taskItemList[iter_14_2].go, false)
	end
end

function var_0_0.onGetBonus(arg_15_0, arg_15_1)
	arg_15_0:_refreshTask()
end

function var_0_0.updateDeadline(arg_16_0)
	local var_16_0 = ActivityModel.instance:getActEndTime(arg_16_0.actId) / 1000 - tonumber(arg_16_0._actMO.config.param) * 3600 - ServerTime.now()
	local var_16_1 = math.max(0, var_16_0)
	local var_16_2, var_16_3 = TimeUtil.secondToRoughTime2(var_16_1)

	arg_16_0._txtremaintime.text = string.format(luaLang("activity_task_remain_time"), string.format("%s%s", var_16_2, var_16_3))
end

return var_0_0
