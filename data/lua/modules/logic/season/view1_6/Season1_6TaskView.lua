module("modules.logic.season.view1_6.Season1_6TaskView", package.seeall)

local var_0_0 = class("Season1_6TaskView", BaseView)

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

	arg_4_0._items = {}
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
	local var_8_0 = Activity104TaskModel.instance:getTaskSeasonList()
	local var_8_1 = {}
	local var_8_2 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		var_8_1[iter_8_0] = iter_8_1

		if iter_8_1.hasFinished then
			var_8_2 = var_8_2 + 1
		end
	end

	if var_8_2 > 1 then
		table.insert(var_8_1, 1, {
			isTotalGet = true
		})
	end

	arg_8_0._dataList = var_8_1

	TaskDispatcher.cancelTask(arg_8_0.showByLine, arg_8_0)

	if arg_8_1 then
		for iter_8_2, iter_8_3 in ipairs(arg_8_0._items) do
			iter_8_3:hide()
		end

		arg_8_0._repeatCount = 0

		TaskDispatcher.runRepeat(arg_8_0.showByLine, arg_8_0, 0.04, #arg_8_0._dataList)
	else
		for iter_8_4 = 1, math.max(#arg_8_0._dataList, #arg_8_0._items) do
			local var_8_3 = arg_8_0:getItem(iter_8_4)
			local var_8_4 = arg_8_0._dataList[iter_8_4]

			var_8_3:onUpdateMO(var_8_4)
		end
	end
end

function var_0_0.showByLine(arg_9_0)
	arg_9_0._repeatCount = arg_9_0._repeatCount + 1

	local var_9_0 = arg_9_0._repeatCount
	local var_9_1 = arg_9_0:getItem(var_9_0)
	local var_9_2 = arg_9_0._dataList[var_9_0]

	var_9_1:onUpdateMO(var_9_2, true)

	if var_9_0 >= #arg_9_0._dataList then
		TaskDispatcher.cancelTask(arg_9_0.showByLine, arg_9_0)
	end
end

function var_0_0.getItem(arg_10_0, arg_10_1)
	if arg_10_0._items[arg_10_1] then
		return arg_10_0._items[arg_10_1]
	end

	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes[1]
	local var_10_1 = arg_10_0:getResInst(var_10_0, arg_10_0._goContent, "item" .. arg_10_1)
	local var_10_2 = Season1_6TaskItem.New(var_10_1, arg_10_0._goScroll)

	arg_10_0._items[arg_10_1] = var_10_2

	return var_10_2
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.refreshTask, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.showByLine, arg_11_0)
	arg_11_0._simagebg:UnLoadImage()

	for iter_11_0, iter_11_1 in pairs(arg_11_0._items) do
		iter_11_1:destroy()
	end

	arg_11_0._items = nil
end

return var_0_0
