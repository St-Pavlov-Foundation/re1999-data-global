module("modules.logic.survival.controller.work.SurvivalDecreeVoteFlowSequence", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteFlowSequence", FlowSequence)

function var_0_0.isFlowDone(arg_1_0)
	return arg_1_0.status == WorkStatus.Done
end

function var_0_0.tryJumpNextWork(arg_2_0)
	local var_2_0 = arg_2_0._workList[arg_2_0._curIndex]

	if not var_2_0 then
		return
	end

	if var_2_0 and var_2_0.canJump then
		var_2_0:onDone(true)
	end
end

return var_0_0
