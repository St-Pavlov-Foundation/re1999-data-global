module("framework.core.taskdispatcher.TaskDispatcher", package.seeall)

local var_0_0 = {}

var_0_0.Idle = 1
var_0_0.Active = 2
var_0_0.ToInsert = 3
var_0_0.ToDelete = 4

function var_0_0.init()
	UpdateBeat:Add(var_0_0._onUnityUpdate, var_0_0)

	var_0_0._taskPool = TaskItem.createPool()
	var_0_0._allTasks = {}
	var_0_0._onceIdxList = {}
	var_0_0._deltaTasks = {}
	var_0_0._isDispatching = false
end

function var_0_0.runDelay(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0 or not arg_2_2 then
		logError("TaskDispatcher.runDelay, callback or delay should not be null!")

		return
	end

	var_0_0._addNewTask(arg_2_0, arg_2_1, arg_2_2, 1, false)
end

function var_0_0.runRepeat(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0 or not arg_3_2 then
		logError("TaskDispatcher.runDelay, callback or interval should not be null!")

		return
	end

	var_0_0._addNewTask(arg_3_0, arg_3_1, arg_3_2, arg_3_3 or -1, true)
end

function var_0_0.cancelTask(arg_4_0, arg_4_1)
	if var_0_0._isDispatching then
		local var_4_0 = var_0_0._getTaskWhichCbInDispatch(arg_4_0, arg_4_1)

		if var_4_0 then
			var_4_0.status = var_0_0.ToDelete
		end

		var_0_0._removeFromDeltaQueue(arg_4_0, arg_4_1)

		local var_4_1 = var_0_0._taskPool:getObject()

		var_4_1.status = var_0_0.ToDelete

		var_4_1:setCb(arg_4_0, arg_4_1)
		table.insert(var_0_0._deltaTasks, var_4_1)
	else
		var_0_0._directDelete(arg_4_0, arg_4_1)
	end
end

function var_0_0._addNewTask(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = false

	if var_0_0._isDispatching then
		local var_5_1 = var_0_0._getTaskInDeltaQueue(arg_5_0, arg_5_1)

		if var_5_1 then
			if var_0_0.ToInsert == var_5_1.status then
				return
			elseif var_0_0.ToDelete == var_5_1.status then
				var_5_0 = true
			end
		end
	end

	local var_5_2 = var_0_0._getTaskWhichCbInDispatch(arg_5_0, arg_5_1)

	if var_5_2 ~= nil and var_5_2.isLoop and var_5_2.status ~= var_0_0.ToDelete and not var_5_0 then
		return
	end

	if var_0_0._isDispatching then
		var_0_0._removeFromDeltaQueue(arg_5_0, arg_5_1)
	end

	local var_5_3 = var_0_0._taskPool:getObject()

	var_5_3:setCb(arg_5_0, arg_5_1)

	var_5_3.interval = arg_5_2
	var_5_3.isLoop = arg_5_4
	var_5_3.repeatCount = arg_5_3
	var_5_3.addFrame = TaskItem.frameCount
	var_5_3.status = var_0_0.Active

	if var_0_0._isDispatching then
		var_5_3.status = var_0_0.ToInsert

		table.insert(var_0_0._deltaTasks, var_5_3)
	else
		var_0_0._directAdd(var_5_3)
	end
end

function var_0_0._onUnityUpdate()
	var_0_0._isDispatching = true

	var_0_0._taskTick(Time.deltaTime)

	var_0_0._isDispatching = false

	var_0_0._doAddOrRemove()

	TaskItem.frameCount = TaskItem.frameCount + 1
end

function var_0_0._doAddOrRemove()
	local var_7_0 = #var_0_0._deltaTasks
	local var_7_1

	for iter_7_0 = 1, var_7_0 do
		local var_7_2 = var_0_0._deltaTasks[iter_7_0]

		if var_0_0.ToDelete == var_7_2.status then
			var_0_0._directDelete(var_7_2.callback, var_7_2.cbObj)
		elseif var_0_0.ToInsert == var_7_2.status then
			var_0_0._directAdd(var_7_2)
		end

		var_0_0._deltaTasks[iter_7_0] = nil
	end
end

function var_0_0._removeFromDeltaQueue(arg_8_0, arg_8_1)
	local var_8_0 = #var_0_0._deltaTasks
	local var_8_1

	for iter_8_0 = var_8_0, 1, -1 do
		local var_8_2 = var_0_0._deltaTasks[iter_8_0]

		if var_8_2.callback == arg_8_0 and var_8_2.cbObj == arg_8_1 then
			var_0_0._taskPool:putObject(var_8_2)
			table.remove(var_0_0._deltaTasks, iter_8_0)

			break
		end
	end
end

function var_0_0._directAdd(arg_9_0)
	local var_9_0, var_9_1 = var_0_0._getTaskWhichCbInDispatch(arg_9_0.callback, arg_9_0.cbObj)

	if var_9_0 and var_9_0.status ~= var_0_0.ToDelete then
		var_0_0._taskPool:putObject(arg_9_0)

		return
	end

	if var_9_0 then
		table.remove(var_0_0._allTasks, var_9_1)
	end

	arg_9_0.status = var_0_0.Active

	table.insert(var_0_0._allTasks, arg_9_0)
end

function var_0_0._directDelete(arg_10_0, arg_10_1)
	local var_10_0 = #var_0_0._allTasks
	local var_10_1

	for iter_10_0 = var_10_0, 1, -1 do
		local var_10_2 = var_0_0._allTasks[iter_10_0]

		if var_10_2.callback == arg_10_0 and var_10_2.cbObj == arg_10_1 then
			var_0_0._taskPool:putObject(var_10_2)
			table.remove(var_0_0._allTasks, iter_10_0)
		end
	end
end

function var_0_0._getTaskWhichCbInDispatch(arg_11_0, arg_11_1)
	local var_11_0 = #var_0_0._allTasks
	local var_11_1

	for iter_11_0 = var_11_0, 1, -1 do
		local var_11_2 = var_0_0._allTasks[iter_11_0]

		if var_11_2.callback == arg_11_0 and var_11_2.cbObj == arg_11_1 then
			return var_11_2, iter_11_0
		end
	end

	return nil, 0
end

function var_0_0._getTaskInDeltaQueue(arg_12_0, arg_12_1)
	local var_12_0

	for iter_12_0 = #var_0_0._deltaTasks, 1, -1 do
		local var_12_1 = var_0_0._deltaTasks[iter_12_0]

		if var_12_1.callback == arg_12_0 and var_12_1.cbObj == arg_12_1 then
			return var_12_1
		end
	end

	return nil
end

function var_0_0._taskTick(arg_13_0)
	local var_13_0 = #var_0_0._allTasks
	local var_13_1 = false
	local var_13_2

	for iter_13_0 = 1, var_13_0 do
		local var_13_3 = var_0_0._allTasks[iter_13_0]

		if var_0_0.ToDelete ~= var_13_3.status and var_13_3:update(arg_13_0) and var_13_3.repeatCount == 0 then
			table.insert(var_0_0._onceIdxList, iter_13_0)
		end
	end

	for iter_13_1 = #var_0_0._onceIdxList, 1, -1 do
		local var_13_4 = var_0_0._onceIdxList[iter_13_1]

		var_0_0._taskPool:putObject(var_0_0._allTasks[var_13_4])
		table.remove(var_0_0._allTasks, var_13_4)
		table.remove(var_0_0._onceIdxList, iter_13_1)
	end
end

function var_0_0._logToBeDeleteItems()
	local var_14_0 = "TaskDispatcher._logToBeDeleteItems: "

	for iter_14_0, iter_14_1 in ipairs(var_0_0._allTasks) do
		if iter_14_1.status == var_0_0.ToDelete then
			var_14_0 = var_14_0 .. iter_14_0 .. " = " .. iter_14_1:logStr() .. "\n"
		end
	end

	logWarn(var_14_0)
end

function var_0_0._logAllTasks()
	local var_15_0 = "TaskDispatcher._logToBeDeleteItems: "

	for iter_15_0, iter_15_1 in ipairs(var_0_0._allTasks) do
		var_15_0 = var_15_0 .. iter_15_0 .. " = " .. iter_15_1:logStr() .. "\n"
	end

	logWarn(var_15_0)
end

return var_0_0
