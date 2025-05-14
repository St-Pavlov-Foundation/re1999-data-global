module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessTaskView", package.seeall)

local var_0_0 = class("Activity1_3ChessTaskView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_TaskList/Viewport/Content")
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

function var_0_0._btnnotfinishbgOnClick(arg_4_0)
	return
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	return
end

function var_0_0._btngetallOnClick(arg_6_0)
	return
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simageFullBG:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_mission_fullbg"))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_9_0._oneClaimReward, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_9_0._onFinishTask, arg_9_0)
	arg_9_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickEpisode, arg_9_0._onGotoTaskEpisode, arg_9_0)
	Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
end

function var_0_0._oneClaimReward(arg_10_0)
	Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
end

function var_0_0._onFinishTask(arg_11_0, arg_11_1)
	if Activity122TaskListModel.instance:getById(arg_11_1) then
		Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
	end
end

function var_0_0._onGotoTaskEpisode(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simageFullBG:UnLoadImage()
end

return var_0_0
