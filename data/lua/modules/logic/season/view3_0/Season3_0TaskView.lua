module("modules.logic.season.view3_0.Season3_0TaskView", package.seeall)

local var_0_0 = class("Season3_0TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goScroll = gohelper.findChild(arg_1_0.viewGO, "#scroll_tasklist")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_tasklist/Viewport/Content")

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
	arg_4_0._simagebg:LoadImage(SeasonViewHelper.getSeasonIcon("full/bg1.png"))
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_5_0.updateTask, arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_5_0.updateTask, arg_5_0)
	arg_5_0:refreshTask(true)
end

function var_0_0.onClose(arg_6_0)
	arg_6_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_6_0.updateTask, arg_6_0)
	arg_6_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0.updateTask, arg_6_0)
end

function var_0_0.updateTask(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.refreshTask, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0.refreshTask, arg_7_0, 0.2)
end

function var_0_0.refreshTask(arg_8_0, arg_8_1)
	Activity104TaskListModel.instance:refreshList()
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.refreshTask, arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
end

return var_0_0
