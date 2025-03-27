module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiTaskView", package.seeall)

slot0 = class("WuErLiXiTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	WuErLiXiTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity180
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showLeftTime()
end

function slot0._oneClaimReward(slot0)
	WuErLiXiTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.WuErLiXi)
end

function slot0._onFinishTask(slot0, slot1)
	if WuErLiXiTaskListModel.instance:getById(slot1) then
		WuErLiXiTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.WuErLiXi)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = WuErLiXiHelper.getLimitTimeStr()
end

function slot0.onClose(slot0)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnCloseTask)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

return slot0
