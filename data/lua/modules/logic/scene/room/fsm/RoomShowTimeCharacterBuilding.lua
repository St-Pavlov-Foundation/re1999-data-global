module("modules.logic.scene.room.fsm.RoomShowTimeCharacterBuilding", package.seeall)

local var_0_0 = class("RoomShowTimeCharacterBuilding", JompFSMBaseTransition)

function var_0_0.start(arg_1_0)
	return
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._interationId = arg_3_1.id
	arg_3_0._actionDict = arg_3_0._actionDict or {}

	local var_3_0 = arg_3_0._actionDict[arg_3_0._interationId]

	if not var_3_0 then
		var_3_0 = RoomActionShowTimeCharacterBuilding.New(arg_3_0)
		arg_3_0._actionDict[arg_3_0._interationId] = var_3_0
	end

	var_3_0:start(arg_3_1)
	arg_3_0:onDone()
end

function var_0_0.endState(arg_4_0)
	arg_4_0.fsm:endTransition(arg_4_0.fromStateName)
end

function var_0_0.stop(arg_5_0)
	arg_5_0:endState()
end

function var_0_0.clear(arg_6_0)
	arg_6_0:endState()
end

return var_0_0
