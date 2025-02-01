module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTaskView", package.seeall)

slot0 = class("TianShiNaNaTaskView", BaseView)

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
	TianShiNaNaTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity167
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showLeftTime()
end

function slot0._oneClaimReward(slot0)
	TianShiNaNaTaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
end

function slot0._onFinishTask(slot0, slot1)
	if TianShiNaNaTaskListModel.instance:getById(slot1) then
		TianShiNaNaTaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = TianShiNaNaHelper.getLimitTimeStr()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

return slot0
