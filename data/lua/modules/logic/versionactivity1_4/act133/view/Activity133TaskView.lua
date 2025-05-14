module("modules.logic.versionactivity1_4.act133.view.Activity133TaskView", package.seeall)

local var_0_0 = class("Activity133TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "main/#simage_bg")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "main/#scroll_view")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "main/#scroll_view/Viewport/Content/#go_taskitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._initTaskMoList, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._initTaskMoList, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0._initTaskMoList, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0.onDailyRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._initTaskMoList, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._initTaskMoList, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_3_0._initTaskMoList, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0.onDailyRefresh, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.actId = arg_8_0.viewParam.actId[1]

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
	arg_8_0:_initTaskMoList()
end

function var_0_0._initTaskMoList(arg_9_0)
	Activity133TaskListModel.instance:sortTaskMoList()
end

function var_0_0.onDailyRefresh(arg_10_0)
	Activity133Rpc.instance:sendGet133InfosRequest(VersionActivity1_4Enum.ActivityId.ShipRepair, arg_10_0._initTaskMoList, arg_10_0)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
