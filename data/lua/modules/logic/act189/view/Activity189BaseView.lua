module("modules.logic.act189.view.Activity189BaseView", package.seeall)

local var_0_0 = class("Activity189BaseView", BaseView)

function var_0_0.onOpen(arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, arg_1_0._refresh, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_1_0._onUpdateTaskList, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_1_0._onFinishTask, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_1_0._onFinishTask, arg_1_0)
	arg_1_0:onUpdateParam()
end

function var_0_0.onUpdateParam(arg_2_0)
	Activity189Controller.instance:sendGetTaskInfoRequest(arg_2_0._refresh, arg_2_0)
end

function var_0_0.onClose(arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, arg_3_0._refresh, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_3_0._onFinishTask, arg_3_0)
end

function var_0_0._refresh(arg_4_0)
	Activity189_TaskListModel.instance:setTaskList(arg_4_0:actId())
end

function var_0_0._getTaskType(arg_5_0)
	return Activity189Config.instance:getTaskType()
end

function var_0_0._onUpdateTaskList(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.taskInfo
	local var_6_1 = arg_6_0:_getTaskType()

	for iter_6_0, iter_6_1 in ipairs(var_6_0 or {}) do
		if iter_6_1.type == var_6_1 then
			arg_6_0:_refresh()

			break
		end
	end
end

function var_0_0._onFinishTask(arg_7_0)
	arg_7_0:_refresh()
	Activity189Controller.dispatchEventUpdateActTag(arg_7_0:actId())
end

function var_0_0.getRemainTimeStr(arg_8_0)
	local var_8_0 = Activity189Model.instance:getRemainTimeSec(arg_8_0:actId())

	if var_8_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_8_1, var_8_2, var_8_3, var_8_4 = TimeUtil.secondsToDDHHMMSS(var_8_0)

	if var_8_1 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_8_1,
			var_8_2
		})
	elseif var_8_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_8_2,
			var_8_3
		})
	elseif var_8_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_8_3
		})
	elseif var_8_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function var_0_0.actId(arg_9_0)
	return arg_9_0.viewContainer:actId()
end

return var_0_0
