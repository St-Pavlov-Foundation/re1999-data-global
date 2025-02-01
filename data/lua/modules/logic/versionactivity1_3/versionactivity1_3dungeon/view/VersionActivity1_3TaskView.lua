module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3TaskView", package.seeall)

slot0 = class("VersionActivity1_3TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtPropNum = gohelper.findChildText(slot0.viewGO, "Left/Prop/txt_PropName/#txt_PropNum")
	slot0._btnshop = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Prop/#btn_shop")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshop:AddClickListener(slot0._btnshopOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshop:RemoveClickListener()
end

function slot0._btnshopOnClick(slot0)
	VersionActivity1_3EnterController.instance:openStoreView()
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV1a3TaskViewSinglebg("v1a3_taskview_fullbg"))

	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	slot0:refreshCurrency()
end

function slot0.refreshCurrency(slot0)
	slot0._txtPropNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Planet) and slot1.quantity or 0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._onOpen, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
end

function slot0._onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshRight, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	VersionActivity1_3TaskListModel.instance:initTask()
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.Dungeon]:getRealEndTimeStamp() - ServerTime.now()
	slot3 = Mathf.Floor(slot2 / TimeUtil.OneDaySecond)
	slot5 = Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)
	slot6 = "%s%s%s%s"

	if GameConfig:GetCurLangType() == LangSettings.en then
		slot6 = "%s%s %s%s"
	end

	if slot3 > 0 then
		slot0._txtremaintime.text = string.format(luaLang("remain"), string.format(slot6, slot3, luaLang("time_day"), slot5, luaLang("time_hour")))
	elseif slot5 > 0 then
		slot0._txtremaintime.text = string.format(luaLang("remain"), string.format(slot6, slot5, luaLang("time_hour"), Mathf.Floor(slot4 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond), luaLang("time_minute2")))
	elseif slot8 > 0 then
		slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s", slot8, luaLang("time_minute")))
	else
		slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("<1%s", luaLang("time_minute")))
	end
end

function slot0.refreshRight(slot0)
	VersionActivity1_3TaskListModel.instance:sortTaskMoList()
	VersionActivity1_3TaskListModel.instance:refreshList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
