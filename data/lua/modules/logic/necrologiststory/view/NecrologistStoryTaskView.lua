module("modules.logic.necrologiststory.view.NecrologistStoryTaskView", package.seeall)

local var_0_0 = class("NecrologistStoryTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.simage_Photo = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_Photo")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0.updateTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0.updateTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_3_0.updateTask, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0.updateTask, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.roleStoryId = arg_5_0.viewParam.roleStoryId

	local var_5_0 = RoleStoryConfig.instance:getStoryById(arg_5_0.roleStoryId)

	arg_5_0.simage_Photo:LoadImage(ResUrl.getRoleStoryPhotoIcon(var_5_0.photo))
	arg_5_0:refreshTask(true)
end

function var_0_0.onClose(arg_6_0)
	return
end

function var_0_0.updateTask(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.refreshTask, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0.refreshTask, arg_7_0, 0.2)
end

function var_0_0.refreshTask(arg_8_0, arg_8_1)
	NecrologistStoryTaskListModel.instance:refreshList(arg_8_0.roleStoryId)
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.refreshTask, arg_9_0)
	arg_9_0.simage_Photo:UnLoadImage()
end

return var_0_0
