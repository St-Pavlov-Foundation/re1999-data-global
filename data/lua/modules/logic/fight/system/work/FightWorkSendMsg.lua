module("modules.logic.fight.system.work.FightWorkSendMsg", package.seeall)

local var_0_0 = class("FightWorkSendMsg", FightWorkItem)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1, ...)
	arg_1_0.msgId = arg_1_1
	arg_1_0.param = {
		...
	}
	arg_1_0.paramCount = select("#", ...)
end

function var_0_0.onStart(arg_2_0)
	FightMsgMgr.sendMsg(arg_2_0.msgId, unpack(arg_2_0.param, 1, arg_2_0.paramCount))
	arg_2_0:onDone(true)
end

return var_0_0
