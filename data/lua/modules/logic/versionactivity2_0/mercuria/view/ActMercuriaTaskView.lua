module("modules.logic.versionactivity2_0.mercuria.view.ActMercuriaTaskView", package.seeall)

slot0 = class("ActMercuriaTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity2_0Enum.ActivityId.Mercuria
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	RoleActivityTaskListModel.instance:init(slot0.actId)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function slot0._oneClaimReward(slot0)
	RoleActivityTaskListModel.instance:refreshData()
end

function slot0._onFinishTask(slot0, slot1)
	if RoleActivityTaskListModel.instance:getById(slot1) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	RoleActivityTaskListModel.instance:clearData()
end

function slot0.onDestroyView(slot0)
end

return slot0
