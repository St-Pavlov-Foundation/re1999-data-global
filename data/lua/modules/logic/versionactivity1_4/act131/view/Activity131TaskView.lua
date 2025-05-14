module("modules.logic.versionactivity1_4.act131.view.Activity131TaskView", package.seeall)

local var_0_0 = class("Activity131TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
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
	arg_4_0._simageFullBG:LoadImage(ResUrl.getV1a4Role6SingleBg("v1a4_role6_mission_fullbg"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0._oneClaimReward, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_6_0._onFinishTask, arg_6_0)
	Activity131TaskListModel.instance:init()
end

function var_0_0._oneClaimReward(arg_7_0)
	Activity131TaskListModel.instance:refreshData()
end

function var_0_0._onFinishTask(arg_8_0, arg_8_1)
	if Activity131TaskListModel.instance:getById(arg_8_1) then
		Activity131TaskListModel.instance:refreshData()
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageFullBG:UnLoadImage()
end

return var_0_0
