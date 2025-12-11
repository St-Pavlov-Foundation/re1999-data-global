module("modules.logic.fight.system.work.FightWorkWaitAllOperateDone", package.seeall)

local var_0_0 = class("FightWorkWaitAllOperateDone", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightGameMgr.operateMgr.workComp
	local var_1_1 = arg_1_0:com_registWork(FightWorkFlowSequence)

	for iter_1_0, iter_1_1 in ipairs(var_1_0.workList) do
		if iter_1_1.class.__cname ~= "FightWorkRequestAutoFight" then
			var_1_1:registWork(FightWorkListen2WorkDone, iter_1_1)
		end
	end

	arg_1_0:playWorkAndDone(var_1_1)
end

function var_0_0.onDestructor(arg_2_0)
	return
end

return var_0_0
