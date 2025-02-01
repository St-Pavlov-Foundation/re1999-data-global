module("modules.logic.versionactivity2_1.dungeon.view.task.VersionActivity2_1TaskView", package.seeall)

slot0 = class("VersionActivity2_1TaskView", BaseView)
slot1 = 0.8

function slot0.onInitView(slot0)
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshTaskList, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshTaskList, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshTaskList, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	VersionActivity2_1TaskListModel.instance:initTask()
	slot0:refreshRemainTime()
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	UIBlockMgr.instance:startBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
	TaskDispatcher.runDelay(slot0._delayEndBlock, slot0, uv0)
	slot0:refreshTaskList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function slot0._delayEndBlock(slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
end

function slot0.refreshTaskList(slot0)
	VersionActivity2_1TaskListModel.instance:sortTaskMoList()
	VersionActivity2_1TaskListModel.instance:refreshList()
end

function slot0.refreshRemainTime(slot0)
	slot2 = ""

	if ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.Dungeon] then
		slot2 = slot1:getRemainTimeStr3(false, false)
	end

	slot0._txtLimitTime.text = slot2
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.cancelTask(slot0._delayEndBlock, slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
end

function slot0.onDestroyView(slot0)
end

return slot0
