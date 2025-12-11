module("modules.logic.fight.system.work.FightWorkSendEvent", package.seeall)

local var_0_0 = class("FightWorkSendEvent", FightWorkItem)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1, ...)
	arg_1_0._eventName = arg_1_1
	arg_1_0._param = {
		...
	}
	arg_1_0._paramCount = select("#", ...)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_sendFightEvent(arg_2_0._eventName, unpack(arg_2_0._param, 1, arg_2_0._paramCount))
	arg_2_0:onDone(true)
end

return var_0_0
