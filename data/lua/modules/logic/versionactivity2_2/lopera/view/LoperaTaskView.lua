module("modules.logic.versionactivity2_2.lopera.view.LoperaTaskView", package.seeall)

slot0 = class("LoperaTaskView", BaseView)

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
	Activity168TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity168
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showLeftTime()
end

function slot0._oneClaimReward(slot0)
	Activity168TaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.Lopera)
end

function slot0._onFinishTask(slot0, slot1)
	if Activity168TaskListModel.instance:getById(slot1) then
		Activity168TaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.Lopera)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = slot0:getLimitTimeStr()
end

function slot0.getLimitTimeStr()
	if not ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.Lopera) then
		return ""
	end

	if slot0:getRealEndTimeStamp() - ServerTime.now() > 0 then
		return TimeUtil.SecondToActivityTimeFormat(slot1)
	end

	return ""
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
