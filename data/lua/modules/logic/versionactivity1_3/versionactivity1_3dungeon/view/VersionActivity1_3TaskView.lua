module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3TaskView", package.seeall)

local var_0_0 = class("VersionActivity1_3TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtPropNum = gohelper.findChildText(arg_1_0.viewGO, "Left/Prop/txt_PropName/#txt_PropNum")
	arg_1_0._btnshop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Prop/#btn_shop")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshop:AddClickListener(arg_2_0._btnshopOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshop:RemoveClickListener()
end

function var_0_0._btnshopOnClick(arg_4_0)
	VersionActivity1_3EnterController.instance:openStoreView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simageFullBG:LoadImage(ResUrl.getV1a3TaskViewSinglebg("v1a3_taskview_fullbg"))

	arg_5_0._txtremaintime = gohelper.findChildText(arg_5_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	arg_5_0:refreshCurrency()
end

function var_0_0.refreshCurrency(arg_6_0)
	local var_6_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Planet)
	local var_6_1 = var_6_0 and var_6_0.quantity or 0

	arg_6_0._txtPropNum.text = GameUtil.numberDisplay(var_6_1)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, arg_8_0._onOpen, arg_8_0)
	arg_8_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0.refreshCurrency, arg_8_0)
end

function var_0_0._onOpen(arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_9_0.refreshRight, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_9_0.refreshRight, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_9_0.refreshRight, arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0.refreshRemainTime, arg_9_0, TimeUtil.OneMinuteSecond)
	VersionActivity1_3TaskListModel.instance:initTask()
	arg_9_0:refreshLeft()
	arg_9_0:refreshRight()
end

function var_0_0.refreshLeft(arg_10_0)
	arg_10_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_11_0)
	local var_11_0 = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.Dungeon]:getRealEndTimeStamp() - ServerTime.now()
	local var_11_1 = Mathf.Floor(var_11_0 / TimeUtil.OneDaySecond)
	local var_11_2 = var_11_0 % TimeUtil.OneDaySecond
	local var_11_3 = Mathf.Floor(var_11_2 / TimeUtil.OneHourSecond)
	local var_11_4 = "%s%s%s%s"

	if GameConfig:GetCurLangType() == LangSettings.en then
		var_11_4 = "%s%s %s%s"
	end

	if var_11_1 > 0 then
		arg_11_0._txtremaintime.text = string.format(luaLang("remain"), string.format(var_11_4, var_11_1, luaLang("time_day"), var_11_3, luaLang("time_hour")))
	else
		local var_11_5 = var_11_2 % TimeUtil.OneHourSecond
		local var_11_6 = Mathf.Floor(var_11_5 / TimeUtil.OneMinuteSecond)

		if var_11_3 > 0 then
			arg_11_0._txtremaintime.text = string.format(luaLang("remain"), string.format(var_11_4, var_11_3, luaLang("time_hour"), var_11_6, luaLang("time_minute2")))
		elseif var_11_6 > 0 then
			arg_11_0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s", var_11_6, luaLang("time_minute")))
		else
			arg_11_0._txtremaintime.text = string.format(luaLang("remain"), string.format("<1%s", luaLang("time_minute")))
		end
	end
end

function var_0_0.refreshRight(arg_12_0)
	VersionActivity1_3TaskListModel.instance:sortTaskMoList()
	VersionActivity1_3TaskListModel.instance:refreshList()
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.refreshRemainTime, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simageFullBG:UnLoadImage()
end

return var_0_0
