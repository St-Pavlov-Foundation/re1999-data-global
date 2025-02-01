module("modules.logic.versionactivity1_7.dungeon.view.task.VersionActivity1_7TaskView", package.seeall)

slot0 = class("VersionActivity1_7TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageLangTxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage("singlebg/v1a7_mainactivity_singlebg/v1a7_task_fullbg.png")
	slot0._simageLangTxt:LoadImage("singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_task_title.png")

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
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	VersionActivity1_7TaskListModel.instance:initTask()
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(ActivityModel.instance:getActivityInfo()[VersionActivity1_7Enum.ActivityId.Dungeon]:getRealEndTimeStamp() - ServerTime.now())
end

function slot0.refreshRight(slot0)
	VersionActivity1_7TaskListModel.instance:sortTaskMoList()
	VersionActivity1_7TaskListModel.instance:refreshList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageLangTxt:UnLoadImage()
end

return slot0
