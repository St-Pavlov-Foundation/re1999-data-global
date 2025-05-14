module("modules.logic.room.utils.fsm.SimpleFSM", package.seeall)

local var_0_0 = class("SimpleFSM")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.context = arg_1_1
	arg_1_0.states = {}
	arg_1_0.transitions = {}
	arg_1_0.isRunning = false
	arg_1_0.isTransitioning = false
	arg_1_0.curStateName = nil
end

function var_0_0.registerState(arg_2_0, arg_2_1)
	if arg_2_1.fsm then
		return
	end

	if arg_2_0.states[arg_2_1.name] then
		return
	end

	arg_2_1:register(arg_2_0, arg_2_0.context)

	arg_2_0.states[arg_2_1.name] = arg_2_1
end

function var_0_0.registerTransition(arg_3_0, arg_3_1)
	if arg_3_1.fsm then
		return
	end

	if arg_3_0.transitions[arg_3_1.name] then
		return
	end

	if string.nilorempty(arg_3_1.fromStateName) or string.nilorempty(arg_3_1.toStateName) or not arg_3_1.eventId then
		return
	end

	if not arg_3_0.states[arg_3_1.fromStateName] or not arg_3_0.states[arg_3_1.toStateName] then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.transitions) do
		if iter_3_1.fromStateName == arg_3_1.fromStateName and iter_3_1.eventId == arg_3_1.eventId then
			return
		end
	end

	arg_3_1:register(arg_3_0, arg_3_0.context)

	arg_3_0.transitions[arg_3_1.name] = arg_3_1
end

function var_0_0.triggerEvent(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.isRunning or arg_4_0.isTransitioning then
		return
	end

	if string.nilorempty(arg_4_0.curStateName) then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.transitions) do
		if iter_4_1.fromStateName == arg_4_0.curStateName and iter_4_1.eventId == arg_4_1 and iter_4_1:check() then
			arg_4_0:startTransition(iter_4_1, arg_4_2)

			break
		end
	end
end

function var_0_0.startTransition(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.isTransitioning = true

	arg_5_0:leaveState(arg_5_0.curStateName)
	arg_5_1:onStart(arg_5_2)
end

function var_0_0.endTransition(arg_6_0, arg_6_1)
	arg_6_0.isTransitioning = false

	arg_6_0:enterState(arg_6_1)
end

function var_0_0.enterState(arg_7_0, arg_7_1)
	arg_7_0.curStateName = arg_7_1

	arg_7_0.states[arg_7_0.curStateName]:onEnter()
end

function var_0_0.leaveState(arg_8_0)
	local var_8_0 = arg_8_0.curStateName

	arg_8_0.curStateName = nil

	arg_8_0.states[var_8_0]:onLeave()
end

function var_0_0.start(arg_9_0, arg_9_1)
	if arg_9_0.isRunning then
		return
	end

	if string.nilorempty(arg_9_1) then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.states) do
		iter_9_1:start()
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.transitions) do
		iter_9_3:start()
	end

	arg_9_0.isRunning = true
	arg_9_0.isTransitioning = false

	arg_9_0:enterState(arg_9_1)
end

function var_0_0.stop(arg_10_0)
	if not arg_10_0.isRunning then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0.states) do
		iter_10_1:stop()
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0.transitions) do
		iter_10_3:stop()
	end

	arg_10_0.isRunning = false
	arg_10_0.isTransitioning = false
	arg_10_0.curStateName = nil
end

function var_0_0.clear(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.states) do
		iter_11_1:clear()
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0.transitions) do
		iter_11_3:clear()
	end
end

return var_0_0
