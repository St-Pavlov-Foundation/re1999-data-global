module("modules.logic.versionactivity1_5.act142.view.Activity142TaskView", package.seeall)

slot0 = class("Activity142TaskView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._goLimitTime = gohelper.findChild(slot0.viewGO, "Left/LimitTime")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:addEventCb(Activity142Controller.instance, Activity142Event.ClickEpisode, slot0._onGotoTaskEpisode, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:removeEventCb(Activity142Controller.instance, Activity142Event.ClickEpisode, slot0._onGotoTaskEpisode, slot0)
end

function slot0._oneClaimReward(slot0)
	Activity142TaskListModel.instance:init(Activity142Model.instance:getActivityId())
end

function slot0._onFinishTask(slot0, slot1)
	if Activity142TaskListModel.instance:getById(slot1) then
		Activity142TaskListModel.instance:init(Activity142Model.instance:getActivityId())
	end
end

function slot0._onGotoTaskEpisode(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goLimitTime, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
	Activity142TaskListModel.instance:init(Activity142Model.instance:getActivityId())
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:_showLeftTime()
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = Activity142Model.instance:getRemainTimeStr(Activity142Model.instance:getActivityId())
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
