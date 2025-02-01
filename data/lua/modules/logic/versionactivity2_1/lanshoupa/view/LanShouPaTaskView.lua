module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaTaskView", package.seeall)

slot0 = class("LanShouPaTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

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
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	Activity164TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity164
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showLeftTime()
end

function slot0._oneClaimReward(slot0)
	Activity164TaskListModel.instance:init(VersionActivity2_1Enum.ActivityId.LanShouPa)
end

function slot0._onFinishTask(slot0, slot1)
	if Activity164TaskListModel.instance:getById(slot1) then
		Activity164TaskListModel.instance:init(VersionActivity2_1Enum.ActivityId.LanShouPa)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = LanShouPaHelper.getLimitTimeStr()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
