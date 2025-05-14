module("modules.logic.versionactivity2_5.act186.view.Activity186TaskView", package.seeall)

local var_0_0 = class("Activity186TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.stageList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, arg_2_0.onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateTask, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.FinishTask, arg_2_0.onFinishTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_2_0.refreshTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateInfo(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onFinishTask(arg_6_0)
	arg_6_0:refreshTask()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_details_open)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshParam(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.actId
	arg_9_0.actMo = Activity186Model.instance:getById(arg_9_0.actId)

	Activity186TaskListModel.instance:init(arg_9_0.actId)
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0:refreshTask()
	arg_10_0:refreshStageList()
end

function var_0_0.refreshTask(arg_11_0)
	Activity186TaskListModel.instance:refresh()
end

function var_0_0.refreshStageList(arg_12_0)
	for iter_12_0 = 1, 3 do
		local var_12_0 = arg_12_0.stageList[iter_12_0]

		if not var_12_0 then
			local var_12_1 = gohelper.findChild(arg_12_0.viewGO, "root/stageList/stage" .. iter_12_0)

			var_12_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, Activity186StageItem)
			arg_12_0.stageList[iter_12_0] = var_12_0
		end

		var_12_0:onUpdateMO({
			id = iter_12_0,
			actMo = arg_12_0.actMo
		})
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
