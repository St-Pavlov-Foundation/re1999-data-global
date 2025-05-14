module("modules.logic.room.utils.fsm.JompFSMBaseTransition", package.seeall)

local var_0_0 = class("JompFSMBaseTransition", SimpleFSMBaseTransition)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.jompStateNames = {}

	tabletool.addValues(arg_1_0.jompStateNames, arg_1_4)
end

function var_0_0.onDone(arg_2_0)
	local var_2_0

	for iter_2_0 = 1, #arg_2_0.jompStateNames do
		if arg_2_0:checkJompState(arg_2_0.jompStateNames[iter_2_0]) then
			var_2_0 = arg_2_0.jompStateNames[iter_2_0]

			break
		end
	end

	arg_2_0.fsm:endTransition(var_2_0 or arg_2_0.toStateName)
end

function var_0_0.checkJompState(arg_3_0, arg_3_1)
	return arg_3_1 and RoomFSMHelper.isCanJompTo(arg_3_1)
end

return var_0_0
