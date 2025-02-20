module("modules.logic.versionactivity2_3.newinsight.view.ActivityInsightShowView_2_3", package.seeall)

slot0 = class("ActivityInsightShowView_2_3", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagelogo = gohelper.findChildSingleImage(slot0.viewGO, "#simage_logo")
	slot0._simagelogo2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_logo2")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "timebg/#txt_remainTime")
	slot0._gotaskitem1 = gohelper.findChild(slot0.viewGO, "#go_taskitem1")
	slot0._gotaskitem2 = gohelper.findChild(slot0.viewGO, "#go_taskitem2")
	slot0._gotaskitem3 = gohelper.findChild(slot0.viewGO, "#go_taskitem3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._taskItems = {}

	for slot4 = 1, 3 do
		slot5 = ActivityInsightShowTaskItem_2_3.New()

		slot5:init(slot0["_gotaskitem" .. slot4], slot4)

		slot0._taskItems[slot4] = slot5
	end

	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshTask, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.Act172TaskUpdate, slot0._refreshTask, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshTask, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.Act172TaskUpdate, slot0._refreshTask, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = slot0.viewParam.actId
	slot0._config = ActivityConfig.instance:getActivityCo(slot0._actId)
	slot0._txtdesc.text = slot0._config.actDesc

	slot0:_refreshRemainTime()
	TaskDispatcher.runRepeat(slot0._refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity172
	}, slot0._getInfoSuccess, slot0)
end

function slot0._refreshRemainTime(slot0)
	slot0._txtremainTime.text = string.format(luaLang("remain"), ActivityModel.instance:getActMO(slot0._actId):getRemainTimeStr2ByEndTime())
end

function slot0._getInfoSuccess(slot0)
	for slot4, slot5 in ipairs(slot0._taskItems) do
		slot5:setTask(100 * slot0._actId + slot4)
	end

	slot0:_refreshTask()
end

function slot0._refreshTask(slot0)
	for slot4, slot5 in ipairs(slot0._taskItems) do
		slot5:refresh()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)

	if slot0._taskItems then
		for slot4, slot5 in pairs(slot0._taskItems) do
			slot5:destroy()
		end

		slot0._taskItems = nil
	end
end

return slot0
