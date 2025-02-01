module("modules.logic.versionactivity2_1.aergusi.view.AergusiTaskView", package.seeall)

slot0 = class("AergusiTaskView", BaseView)

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
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollTaskList.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0._onDragBegin(slot0)
	AergusiTaskListModel.instance:setAniDisable(true)
end

function slot0._onDragEnd(slot0)
	AergusiTaskListModel.instance:setAniDisable(false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AergusiTaskListModel.instance:init(VersionActivity2_1Enum.ActivityId.Aergusi)
	slot0:_addEvents()
	TaskDispatcher.runRepeat(slot0._refreshDeadline, slot0, TimeUtil.OneMinuteSecond)
	slot0:_refreshDeadline()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
end

function slot0._oneClaimReward(slot0)
	slot0:_refreshItems()
end

function slot0._onFinishTask(slot0, slot1)
	slot0:_refreshItems()
end

function slot0._refreshDeadline(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_1Enum.ActivityId.Aergusi)
end

function slot0._refreshItems(slot0)
	slot1 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity163)
end

function slot0.onClose(slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._refreshDeadline, slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
