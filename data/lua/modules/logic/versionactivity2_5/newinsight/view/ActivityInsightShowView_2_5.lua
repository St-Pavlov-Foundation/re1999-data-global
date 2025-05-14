module("modules.logic.versionactivity2_5.newinsight.view.ActivityInsightShowView_2_5", package.seeall)

local var_0_0 = class("ActivityInsightShowView_2_5", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagelogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_logo")
	arg_1_0._simagelogo2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_logo2")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "timebg/#txt_remainTime")
	arg_1_0._gotaskitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_taskitem1")
	arg_1_0._gotaskitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_taskitem2")
	arg_1_0._gotaskitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_taskitem3")

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
	arg_4_0._taskItems = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = ActivityInsightShowTaskItem_2_5.New()

		var_4_0:init(arg_4_0["_gotaskitem" .. iter_4_0], iter_4_0)

		arg_4_0._taskItems[iter_4_0] = var_4_0
	end

	arg_4_0:_addEvents()
end

function var_0_0._addEvents(arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_5_0._refreshTask, arg_5_0)
	arg_5_0:addEventCb(ActivityController.instance, ActivityEvent.Act172TaskUpdate, arg_5_0._refreshTask, arg_5_0)
end

function var_0_0._removeEvents(arg_6_0)
	arg_6_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_6_0._refreshTask, arg_6_0)
	arg_6_0:removeEventCb(ActivityController.instance, ActivityEvent.Act172TaskUpdate, arg_6_0._refreshTask, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.parent

	gohelper.addChild(var_8_0, arg_8_0.viewGO)

	arg_8_0._actId = arg_8_0.viewParam.actId
	arg_8_0._config = ActivityConfig.instance:getActivityCo(arg_8_0._actId)
	arg_8_0._txtdesc.text = arg_8_0._config.actDesc

	arg_8_0:_refreshRemainTime()
	TaskDispatcher.runRepeat(arg_8_0._refreshRemainTime, arg_8_0, TimeUtil.OneMinuteSecond)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity172
	}, arg_8_0._getInfoSuccess, arg_8_0)
end

function var_0_0._refreshRemainTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActMO(arg_9_0._actId)

	arg_9_0._txtremainTime.text = string.format(luaLang("remain"), var_9_0:getRemainTimeStr2ByEndTime())
end

function var_0_0._getInfoSuccess(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._taskItems) do
		local var_10_0 = 100 * arg_10_0._actId + iter_10_0

		iter_10_1:setTask(var_10_0)
	end

	arg_10_0:_refreshTask()
end

function var_0_0._refreshTask(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._taskItems) do
		iter_11_1:refresh()
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_13_0._refreshRemainTime, arg_13_0)

	if arg_13_0._taskItems then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._taskItems) do
			iter_13_1:destroy()
		end

		arg_13_0._taskItems = nil
	end
end

return var_0_0
