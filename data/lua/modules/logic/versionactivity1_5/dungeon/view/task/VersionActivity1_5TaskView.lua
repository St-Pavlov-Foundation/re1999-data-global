module("modules.logic.versionactivity1_5.dungeon.view.task.VersionActivity1_5TaskView", package.seeall)

slot0 = class("VersionActivity1_5TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage("singlebg/v1a5_taskview_singlebg/v1a5_taskview_fullbg.png")

	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
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
	VersionActivity1_5TaskListModel.instance:initTask()
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremaintime.text = formatLuaLang("remain", ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.Dungeon]:getRemainTimeStr3())
end

function slot0.refreshRight(slot0)
	VersionActivity1_5TaskListModel.instance:sortTaskMoList()
	VersionActivity1_5TaskListModel.instance:refreshList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
