module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskView", package.seeall)

local var_0_0 = class("AiZiLaTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
	arg_1_0._goLimitTime = gohelper.findChild(arg_1_0.viewGO, "Left/LimitTime")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goLimitTime, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	if arg_6_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_6_0.viewContainer.viewName, arg_6_0.closeThis, arg_6_0)
	end

	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0._oneClaimReward, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_6_0._onFinishTask, arg_6_0)
	AiZiLaTaskListModel.instance:init()
	TaskDispatcher.runRepeat(arg_6_0._showLeftTime, arg_6_0, 1)
	arg_6_0:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_mission_open)
end

function var_0_0._oneClaimReward(arg_7_0)
	AiZiLaTaskListModel.instance:init()
end

function var_0_0._onFinishTask(arg_8_0, arg_8_1)
	if AiZiLaTaskListModel.instance:getById(arg_8_1) then
		AiZiLaTaskListModel.instance:init()
	end
end

function var_0_0._showLeftTime(arg_9_0)
	arg_9_0._txtLimitTime.text = AiZiLaHelper.getLimitTimeStr()
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._showLeftTime, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageFullBG:UnLoadImage()
end

return var_0_0
