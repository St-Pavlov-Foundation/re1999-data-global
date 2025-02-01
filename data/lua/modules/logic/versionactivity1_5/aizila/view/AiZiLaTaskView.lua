module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskView", package.seeall)

slot0 = class("AiZiLaTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._goLimitTime = gohelper.findChild(slot0.viewGO, "Left/LimitTime")
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
	gohelper.setActive(slot0._goLimitTime, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0.closeThis, slot0)
	end

	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	AiZiLaTaskListModel.instance:init()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 1)
	slot0:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_mission_open)
end

function slot0._oneClaimReward(slot0)
	AiZiLaTaskListModel.instance:init()
end

function slot0._onFinishTask(slot0, slot1)
	if AiZiLaTaskListModel.instance:getById(slot1) then
		AiZiLaTaskListModel.instance:init()
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = AiZiLaHelper.getLimitTimeStr()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
