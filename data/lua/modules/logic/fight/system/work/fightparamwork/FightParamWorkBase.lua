module("modules.logic.fight.system.work.fightparamwork.FightParamWorkBase", package.seeall)

local var_0_0 = class("FightParamWorkBase", FightWorkItem)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.keyId = arg_1_1
	arg_1_0.oldValue = arg_1_2
	arg_1_0.currValue = arg_1_3
	arg_1_0.offset = arg_1_4
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:onDone(true)
end

return var_0_0
