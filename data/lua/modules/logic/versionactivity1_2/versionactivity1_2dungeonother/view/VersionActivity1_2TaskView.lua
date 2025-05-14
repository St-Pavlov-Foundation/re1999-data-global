module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2TaskView", package.seeall)

local var_0_0 = class("VersionActivity1_2TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_langtxt")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "left/#simage_langtxt/#txt_remaintime")
	arg_1_0._txtcurrencynum = gohelper.findChildText(arg_1_0.viewGO, "left/node/cn/#txt_currencynum")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_list")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickStore(arg_4_0)
	VersionActivity1_2EnterController.instance:openActivityStoreView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_bj"))

	arg_5_0.storeClick = gohelper.findChildClick(arg_5_0.viewGO, "left/node")

	arg_5_0.storeClick:AddClickListener(arg_5_0.onClickStore, arg_5_0)
	arg_5_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0.refreshCurrency, arg_5_0)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, arg_7_0._onOpen, arg_7_0)
end

function var_0_0._onOpen(arg_8_0)
	arg_8_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_8_0.refreshRight, arg_8_0)
	arg_8_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_8_0.refreshRight, arg_8_0)
	arg_8_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_8_0.refreshRight, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.refreshRemainTime, arg_8_0, TimeUtil.OneMinuteSecond)
	VersionActivity1_2TaskListModel.instance:initTask()
	arg_8_0:refreshLeft()
	arg_8_0:refreshRight()
end

function var_0_0.refreshLeft(arg_9_0)
	arg_9_0:refreshRemainTime()
	arg_9_0:refreshCurrency()
end

function var_0_0.refreshRemainTime(arg_10_0)
	local var_10_0 = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.Dungeon]:getRealEndTimeStamp() - ServerTime.now()
	local var_10_1 = Mathf.Floor(var_10_0 / TimeUtil.OneDaySecond)
	local var_10_2 = var_10_0 % TimeUtil.OneDaySecond
	local var_10_3 = Mathf.Floor(var_10_2 / TimeUtil.OneHourSecond)

	if var_10_1 > 0 then
		if LangSettings.instance:isEn() then
			arg_10_0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s %s%s", var_10_1, luaLang("time_day"), var_10_3, luaLang("time_hour")))
		else
			arg_10_0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", var_10_1, luaLang("time_day"), var_10_3, luaLang("time_hour")))
		end
	else
		local var_10_4 = var_10_2 % TimeUtil.OneHourSecond
		local var_10_5 = Mathf.Floor(var_10_4 / TimeUtil.OneMinuteSecond)

		if var_10_3 > 0 then
			if LangSettings.instance:isEn() then
				arg_10_0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s %s%s", var_10_3, luaLang("time_hour"), var_10_5, luaLang("time_minute2")))
			else
				arg_10_0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", var_10_3, luaLang("time_hour"), var_10_5, luaLang("time_minute2")))
			end
		elseif var_10_5 > 0 then
			arg_10_0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s", var_10_5, luaLang("time_minute")))
		else
			arg_10_0._txtremaintime.text = string.format(luaLang("remain"), string.format("<1%s", luaLang("time_minute")))
		end
	end
end

function var_0_0.refreshCurrency(arg_11_0)
	local var_11_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.LvHuEMen)

	arg_11_0._txtcurrencynum.text = var_11_0 and GameUtil.numberDisplay(var_11_0.quantity) or 0
end

function var_0_0.refreshRight(arg_12_0)
	VersionActivity1_2TaskListModel.instance:sortTaskMoList()
	VersionActivity1_2TaskListModel.instance:refreshList()
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.refreshRemainTime, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagebg:UnLoadImage()
	arg_14_0.storeClick:RemoveClickListener()
end

return var_0_0
