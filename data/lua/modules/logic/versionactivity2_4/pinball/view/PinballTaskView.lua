module("modules.logic.versionactivity2_4.pinball.view.PinballTaskView", package.seeall)

local var_0_0 = class("PinballTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtmainlv = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_main/#txt_lv")
	arg_1_0._goslider1 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_main/#go_slider/#go_slider1")
	arg_1_0._goslider2 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_main/#go_slider/#go_slider2")
	arg_1_0._goslider3 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_main/#go_slider/#go_slider3")
	arg_1_0._txtmainnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_main/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_2_0._refreshMainLv, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.DataInited, arg_2_0._refreshMainLv, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_3_0._refreshMainLv, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, arg_3_0._refreshMainLv, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_4_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_4_0._oneClaimReward, arg_4_0)
	arg_4_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_4_0._onFinishTask, arg_4_0)
	PinballTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity178
	}, arg_4_0._oneClaimReward, arg_4_0)
	TaskDispatcher.runRepeat(arg_4_0._showLeftTime, arg_4_0, 60)
	arg_4_0:_showLeftTime()
	arg_4_0:_refreshMainLv()
end

function var_0_0._refreshMainLv(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = PinballModel.instance:getScoreLevel()
	local var_5_3, var_5_4 = PinballModel.instance:getResNum(PinballEnum.ResType.Score)

	arg_5_0._txtmainlv.text = var_5_0
	arg_5_0._goslider1.fillAmount = 0

	if var_5_2 == var_5_1 then
		arg_5_0._goslider2.fillAmount = 1
	else
		arg_5_0._goslider2.fillAmount = (var_5_3 - var_5_1) / (var_5_2 - var_5_1)
	end

	arg_5_0._goslider3.fillAmount = 0
	arg_5_0._txtmainnum.text = string.format("%d/%d", var_5_3, var_5_2)
end

function var_0_0._oneClaimReward(arg_6_0)
	PinballTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.Pinball)
end

function var_0_0._onFinishTask(arg_7_0, arg_7_1)
	if PinballTaskListModel.instance:getById(arg_7_1) then
		PinballTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.Pinball)
	end
end

function var_0_0._showLeftTime(arg_8_0)
	arg_8_0._txtLimitTime.text = PinballHelper.getLimitTimeStr()
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._showLeftTime, arg_9_0)
end

return var_0_0
