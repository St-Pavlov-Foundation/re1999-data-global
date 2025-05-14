module("framework.mvc.view.ViewDestroyMgr", package.seeall)

local var_0_0 = class("ViewDestroyMgr")

var_0_0.TickInterval = 0.03

function var_0_0.init(arg_1_0)
	arg_1_0._isRunning = false
	arg_1_0._dict = {}
	arg_1_0._priorityQueue = PriorityQueue.New(function(arg_2_0, arg_2_1)
		return arg_2_0.destroyTime < arg_2_1.destroyTime
	end)

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
end

function var_0_0.destroyImmediately(arg_3_0)
	while arg_3_0._priorityQueue:getSize() > 0 do
		local var_3_0 = arg_3_0._priorityQueue:getFirst()

		arg_3_0._priorityQueue:getFirstAndRemove()
		ViewMgr.instance:destroyView(var_3_0.viewName)
	end

	arg_3_0._isRunning = false

	TaskDispatcher.cancelTask(arg_3_0._tick, arg_3_0)
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_0._dict[arg_4_1] then
		arg_4_0._dict[arg_4_1] = nil

		arg_4_0._priorityQueue:markRemove(function(arg_5_0)
			return arg_5_0.viewName == arg_4_1
		end)
	end
end

function var_0_0._onCloseViewFinish(arg_6_0, arg_6_1)
	local var_6_0 = ViewMgr.instance:getSetting(arg_6_1)
	local var_6_1 = Time.realtimeSinceStartup + (var_6_0.destroy or var_0_0.TickInterval)

	arg_6_0._dict[arg_6_1] = true

	arg_6_0._priorityQueue:add({
		viewName = arg_6_1,
		destroyTime = var_6_1
	})

	if not arg_6_0._isRunning then
		arg_6_0._isRunning = true

		TaskDispatcher.runRepeat(arg_6_0._tick, arg_6_0, var_0_0.TickInterval)
	end
end

function var_0_0._tick(arg_7_0)
	local var_7_0 = Time.realtimeSinceStartup

	while arg_7_0._priorityQueue:getSize() > 0 do
		local var_7_1 = arg_7_0._priorityQueue:getFirst()

		if var_7_0 > var_7_1.destroyTime then
			arg_7_0._priorityQueue:getFirstAndRemove()
			ViewMgr.instance:destroyView(var_7_1.viewName)
		else
			break
		end
	end

	if arg_7_0._priorityQueue:getSize() == 0 then
		arg_7_0._isRunning = false

		TaskDispatcher.cancelTask(arg_7_0._tick, arg_7_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
