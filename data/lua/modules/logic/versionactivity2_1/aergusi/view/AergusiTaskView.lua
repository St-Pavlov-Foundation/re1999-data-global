module("modules.logic.versionactivity2_1.aergusi.view.AergusiTaskView", package.seeall)

local var_0_0 = class("AergusiTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
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
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._scrollTaskList.gameObject)

	arg_4_0._drag:AddDragBeginListener(arg_4_0._onDragBegin, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0._onDragEnd, arg_4_0)

	arg_4_0._image_LimitTimeBGGo = gohelper.findChild(arg_4_0.viewGO, "Left/LimitTime/image_LimitTimeBG")

	gohelper.setActive(arg_4_0._image_LimitTimeBGGo, false)
end

function var_0_0._onDragBegin(arg_5_0)
	AergusiTaskListModel.instance:setAniDisable(true)
end

function var_0_0._onDragEnd(arg_6_0)
	AergusiTaskListModel.instance:setAniDisable(false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AergusiTaskListModel.instance:init(VersionActivity2_1Enum.ActivityId.Aergusi)
	arg_8_0:_addEvents()
	TaskDispatcher.runRepeat(arg_8_0._refreshDeadline, arg_8_0, TimeUtil.OneMinuteSecond)
	arg_8_0:_refreshDeadline()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function var_0_0._addEvents(arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_9_0._oneClaimReward, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_9_0._onFinishTask, arg_9_0)
end

function var_0_0._oneClaimReward(arg_10_0)
	arg_10_0:_refreshItems()
end

function var_0_0._onFinishTask(arg_11_0, arg_11_1)
	arg_11_0:_refreshItems()
end

function var_0_0._refreshDeadline(arg_12_0)
	arg_12_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_1Enum.ActivityId.Aergusi)
end

function var_0_0._refreshItems(arg_13_0)
	local var_13_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity163)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0._removeEvents(arg_15_0)
	arg_15_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_15_0._oneClaimReward, arg_15_0)
	arg_15_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_15_0._onFinishTask, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._drag:RemoveDragBeginListener()
	arg_16_0._drag:RemoveDragEndListener()
	arg_16_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_16_0._refreshDeadline, arg_16_0)
	arg_16_0._simageFullBG:UnLoadImage()
end

return var_0_0
