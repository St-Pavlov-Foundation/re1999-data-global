module("modules.common.utils.StateMachine", package.seeall)

local var_0_0 = class("StateMachine")

function var_0_0.Create()
	local var_1_0 = var_0_0.New()

	var_1_0.states = {}
	var_1_0.currentState = nil

	return var_1_0
end

function var_0_0.addState(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_0.states[arg_2_1] == nil then
		arg_2_0.states[arg_2_1] = {}
	end

	arg_2_0.states[arg_2_1].onEnter = arg_2_2
	arg_2_0.states[arg_2_1].onUpdate = arg_2_3
	arg_2_0.states[arg_2_1].onExit = arg_2_4
	arg_2_0._cbObj = arg_2_5
end

function var_0_0.setInitialState(arg_3_0, arg_3_1)
	arg_3_0.currentState = arg_3_1

	if arg_3_0.states[arg_3_1] and arg_3_0.states[arg_3_1].onEnter then
		arg_3_0.states[arg_3_1].onEnter(arg_3_0._cbObj)
	end
end

function var_0_0.transitionTo(arg_4_0, arg_4_1)
	if arg_4_0.currentState == arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0.states[arg_4_0.currentState]
	local var_4_1 = arg_4_0.states[arg_4_1]

	if var_4_0 and var_4_0.onExit then
		var_4_0.onExit(arg_4_0._cbObj)
	end

	arg_4_0.currentState = arg_4_1

	if var_4_1 and var_4_1.onEnter then
		var_4_1.onEnter(arg_4_0._cbObj)
	end
end

function var_0_0.update(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.states[arg_5_0.currentState]

	if var_5_0 and var_5_0.onUpdate then
		var_5_0.onUpdate(arg_5_0._cbObj, arg_5_1)
	end
end

function var_0_0.onDestroy(arg_6_0)
	if arg_6_0.states ~= nil then
		tabletool.clear(arg_6_0.states)

		arg_6_0.states = nil
	end

	arg_6_0._cbObj = nil
end

return var_0_0
