module("modules.logic.versionactivity2_5.autochess.view.AutoChessTaskView", package.seeall)

slot0 = class("AutoChessTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.AutoChess
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:_showLeftTime()
end

function slot0._oneClaimReward(slot0)
	AutoChessTaskListModel.instance:init(slot0.actId)
end

function slot0._onFinishTask(slot0, slot1)
	if AutoChessTaskListModel.instance:getById(slot1) then
		AutoChessTaskListModel.instance:init(slot0.actId)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	AutoChessTaskListModel.instance:clear()
end

return slot0
