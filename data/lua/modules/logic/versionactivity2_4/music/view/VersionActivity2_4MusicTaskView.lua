module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTaskView", package.seeall)

slot0 = class("VersionActivity2_4MusicTaskView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshRight, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshLeft()
	VersionActivity2_4MusicTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity179
	}, slot0._oneClaimReward, slot0)
end

function slot0._oneClaimReward(slot0)
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActivityInfo()[Activity179Model.instance:getActivityId()] and slot2:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(slot3)

		return
	end

	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.refreshRight(slot0)
	VersionActivity2_4MusicTaskListModel.instance:initTask()
	VersionActivity2_4MusicTaskListModel.instance:sortTaskMoList()
	VersionActivity2_4MusicTaskListModel.instance:refreshList()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity2_4MusicOpinionTabView then
		slot0:closeThis()
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
