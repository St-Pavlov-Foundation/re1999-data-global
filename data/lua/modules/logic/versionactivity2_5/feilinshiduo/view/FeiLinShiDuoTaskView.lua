module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoTaskView", package.seeall)

slot0 = class("FeiLinShiDuoTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)

	slot0.actId = slot0.viewParam.activityId

	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	FeiLinShiDuoTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity185
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0.showLeftTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:showLeftTime()
end

function slot0._oneClaimReward(slot0)
	FeiLinShiDuoTaskListModel.instance:init(slot0.actId)
end

function slot0._onFinishTask(slot0, slot1)
	if FeiLinShiDuoTaskListModel.instance:getById(slot1) then
		FeiLinShiDuoTaskListModel.instance:init(slot0.actId)
	end
end

function slot0.showLeftTime(slot0)
	slot0._txttime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
