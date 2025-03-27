module("modules.logic.versionactivity2_4.pinball.view.PinballTaskView", package.seeall)

slot0 = class("PinballTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtmainlv = gohelper.findChildTextMesh(slot0.viewGO, "Left/#go_main/#txt_lv")
	slot0._goslider1 = gohelper.findChildImage(slot0.viewGO, "Left/#go_main/#go_slider/#go_slider1")
	slot0._goslider2 = gohelper.findChildImage(slot0.viewGO, "Left/#go_main/#go_slider/#go_slider2")
	slot0._goslider3 = gohelper.findChildImage(slot0.viewGO, "Left/#go_main/#go_slider/#go_slider3")
	slot0._txtmainnum = gohelper.findChildTextMesh(slot0.viewGO, "Left/#go_main/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshMainLv, slot0)
	PinballController.instance:registerCallback(PinballEvent.DataInited, slot0._refreshMainLv, slot0)
end

function slot0.removeEvents(slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshMainLv, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, slot0._refreshMainLv, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	PinballTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity178
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showLeftTime()
	slot0:_refreshMainLv()
end

function slot0._refreshMainLv(slot0)
	slot0._txtmainlv.text, slot2, slot3 = PinballModel.instance:getScoreLevel()
	slot4, slot5 = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
	slot0._goslider1.fillAmount = 0

	if slot3 == slot2 then
		slot0._goslider2.fillAmount = 1
	else
		slot0._goslider2.fillAmount = (slot4 - slot2) / (slot3 - slot2)
	end

	slot0._goslider3.fillAmount = 0
	slot0._txtmainnum.text = string.format("%d/%d", slot4, slot3)
end

function slot0._oneClaimReward(slot0)
	PinballTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.Pinball)
end

function slot0._onFinishTask(slot0, slot1)
	if PinballTaskListModel.instance:getById(slot1) then
		PinballTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.Pinball)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = PinballHelper.getLimitTimeStr()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

return slot0
