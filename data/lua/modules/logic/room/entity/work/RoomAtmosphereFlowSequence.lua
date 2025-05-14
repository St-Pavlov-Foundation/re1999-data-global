module("modules.logic.room.entity.work.RoomAtmosphereFlowSequence", package.seeall)

local var_0_0 = class("RoomAtmosphereFlowSequence", FlowSequence)
local var_0_1 = "done"

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._doneParam = arg_1_1
end

function var_0_0.setAllWorkAudioIsFade(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._workList) do
		iter_2_1:setAudioIsFade(arg_2_1)
	end
end

function var_0_0.onDone(arg_3_0, arg_3_1)
	arg_3_0.isSuccess = arg_3_1
	arg_3_0.status = WorkStatus.Done

	arg_3_0:clearWork()

	if arg_3_0.parent then
		arg_3_0.parent:onWorkDone(arg_3_0)
	end

	if arg_3_0._dispatcher then
		arg_3_0._dispatcher:dispatchEvent(var_0_1, arg_3_1, arg_3_0._doneParam)
	end
end

return var_0_0
