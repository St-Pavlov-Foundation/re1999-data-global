module("modules.logic.fight.system.flow.FightRestartSequence", package.seeall)

local var_0_0 = class("FightRestartSequence", BaseFightSequence)

var_0_0.RestartType2Type = {
	[38] = 34,
	[121] = 1,
	[123] = 1,
	[14] = 1,
	[122] = 1,
	[191] = 1,
	[201] = 1,
	[202] = 1,
	[24] = 23,
	[143] = 1,
	[31] = 166,
	[34] = 34,
	[161] = 1,
	[21] = 1,
	[32] = 166,
	[183] = 1,
	[36] = 34,
	[181] = 1,
	[99] = 1,
	[19] = 1,
	[124] = 1,
	[151] = 1,
	[35] = 34,
	[135] = 131,
	[134] = 131,
	[133] = 131,
	[132] = 131
}

function var_0_0.buildFlow(arg_1_0)
	var_0_0.super.buildFlow(arg_1_0)

	local var_1_0 = FightModel.instance:getFightParam()

	arg_1_0:addWork(FightWorkRestartAbandon.New(var_1_0))
	arg_1_0:addWork(FunctionWork.New(arg_1_0.startRestartGame, arg_1_0))
	arg_1_0:addWork(FightWorkRestartBefore.New(var_1_0))
	arg_1_0:addWork(FightWorkRestartRequest.New(var_1_0))
end

function var_0_0.startRestartGame(arg_2_0)
	FightMsgMgr.sendMsg(FightMsgId.RestartGame)
end

return var_0_0
