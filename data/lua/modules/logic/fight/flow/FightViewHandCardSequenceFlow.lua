module("modules.logic.fight.flow.FightViewHandCardSequenceFlow", package.seeall)

local var_0_0 = class("FightViewHandCardSequenceFlow", FlowSequence)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowCreate, arg_1_0)
end

function var_0_0.start(arg_2_0, arg_2_1)
	var_0_0.super.start(arg_2_0, arg_2_1)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowStart, arg_2_0)
end

function var_0_0.onDone(arg_3_0, arg_3_1)
	var_0_0.super.onDone(arg_3_0, arg_3_1)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, arg_3_0)
end

function var_0_0.stop(arg_4_0)
	var_0_0.super.stop(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, arg_4_0)
end

return var_0_0
