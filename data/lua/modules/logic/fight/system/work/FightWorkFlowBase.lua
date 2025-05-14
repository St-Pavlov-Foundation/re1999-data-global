module("modules.logic.fight.system.work.FightWorkFlowBase", package.seeall)

local var_0_0 = class("FightWorkFlowBase", FightWorkItem)
local var_0_1 = 10

function var_0_0.start(arg_1_0, arg_1_1)
	if arg_1_0.PARENT_ROOT_CLASS then
		if isTypeOf(arg_1_0.PARENT_ROOT_CLASS, FightWorkFlowSequence) or isTypeOf(arg_1_0.PARENT_ROOT_CLASS, var_0_0) then
			arg_1_0.ROOTFLOW = arg_1_0.PARENT_ROOT_CLASS.ROOTFLOW
			arg_1_0.ROOTFLOW.COUNTERDEEP = arg_1_0.ROOTFLOW.COUNTERDEEP + 1
			arg_1_0.COUNTERDEEP = arg_1_0.ROOTFLOW.COUNTERDEEP
		else
			arg_1_0.ROOTFLOW = arg_1_0
			arg_1_0.COUNTERDEEP = 0
		end
	else
		arg_1_0.ROOTFLOW = arg_1_0
		arg_1_0.COUNTERDEEP = 0
	end

	if arg_1_0.COUNTERDEEP == 0 then
		return FightWorkItem.start(arg_1_0, arg_1_1)
	elseif arg_1_0.COUNTERDEEP % var_0_1 == 0 then
		return arg_1_0:com_registTimer(FightWorkItem.start, 0.01, arg_1_1)
	else
		return FightWorkItem.start(arg_1_0, arg_1_1)
	end
end

function var_0_0.onDestructorFinish(arg_2_0)
	if not arg_2_0.COUNTERDEEP then
		return FightWorkItem.onDestructorFinish(arg_2_0)
	end

	if arg_2_0.COUNTERDEEP == 0 then
		return FightWorkItem.onDestructorFinish(arg_2_0)
	elseif arg_2_0.COUNTERDEEP % var_0_1 == 0 then
		return FightTimer.registTimer(FightWorkItem.onDestructorFinish, arg_2_0, 0.01)
	else
		return FightWorkItem.onDestructorFinish(arg_2_0)
	end
end

return var_0_0
