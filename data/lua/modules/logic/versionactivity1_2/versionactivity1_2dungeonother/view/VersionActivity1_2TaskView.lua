module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2TaskView", package.seeall)

slot0 = class("VersionActivity1_2TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_langtxt")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "left/#simage_langtxt/#txt_remaintime")
	slot0._txtcurrencynum = gohelper.findChildText(slot0.viewGO, "left/node/cn/#txt_currencynum")
	slot0._scrolllist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_list")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickStore(slot0)
	VersionActivity1_2EnterController.instance:openActivityStoreView()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_bj"))

	slot0.storeClick = gohelper.findChildClick(slot0.viewGO, "left/node")

	slot0.storeClick:AddClickListener(slot0.onClickStore, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._onOpen, slot0)
end

function slot0._onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshRight, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	VersionActivity1_2TaskListModel.instance:initTask()
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
	slot0:refreshCurrency()
end

function slot0.refreshRemainTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.Dungeon]:getRealEndTimeStamp() - ServerTime.now()

	if Mathf.Floor(slot2 / TimeUtil.OneDaySecond) > 0 then
		if LangSettings.instance:isEn() then
			slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s %s%s", slot3, luaLang("time_day"), Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond), luaLang("time_hour")))
		else
			slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", slot3, luaLang("time_day"), slot5, luaLang("time_hour")))
		end
	elseif slot5 > 0 then
		if LangSettings.instance:isEn() then
			slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s %s%s", slot5, luaLang("time_hour"), Mathf.Floor(slot4 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond), luaLang("time_minute2")))
		else
			slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", slot5, luaLang("time_hour"), slot7, luaLang("time_minute2")))
		end
	elseif slot7 > 0 then
		slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s", slot7, luaLang("time_minute")))
	else
		slot0._txtremaintime.text = string.format(luaLang("remain"), string.format("<1%s", luaLang("time_minute")))
	end
end

function slot0.refreshCurrency(slot0)
	slot0._txtcurrencynum.text = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.LvHuEMen) and GameUtil.numberDisplay(slot1.quantity) or 0
end

function slot0.refreshRight(slot0)
	VersionActivity1_2TaskListModel.instance:sortTaskMoList()
	VersionActivity1_2TaskListModel.instance:refreshList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0.storeClick:RemoveClickListener()
end

return slot0
