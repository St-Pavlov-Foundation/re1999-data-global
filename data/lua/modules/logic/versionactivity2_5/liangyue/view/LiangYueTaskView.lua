module("modules.logic.versionactivity2_5.liangyue.view.LiangYueTaskView", package.seeall)

slot0 = class("LiangYueTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onOpen(slot0)
	slot0._actId = VersionActivity2_5Enum.ActivityId.LiangYue

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	LiangYueTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity184
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0.showLeftTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:showLeftTime()
end

function slot0._oneClaimReward(slot0)
	LiangYueTaskListModel.instance:init(slot0._actId)
end

function slot0._onFinishTask(slot0, slot1)
	if LiangYueTaskListModel.instance:getById(slot1) then
		LiangYueTaskListModel.instance:init(slot0._actId)
	end
end

function slot0.showLeftTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0._actId)
end

function slot0.onClose(slot0)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnCloseTask)
	TaskDispatcher.cancelTask(slot0.showLeftTime, slot0)
end

return slot0
