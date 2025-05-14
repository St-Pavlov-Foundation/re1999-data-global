module("modules.logic.fight.mgr.FightPlayMgr", package.seeall)

local var_0_0 = class("FightPlayMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0:com_registFightEvent(FightEvent.EnterStage, arg_1_0._onEnterStage)
	arg_1_0:com_registFightEvent(FightEvent.ExitStage, arg_1_0._onExitStage)
	arg_1_0:com_registMsg(FightMsgId.PlayDouQuQu, arg_1_0._onPlayDouQuQu)
	arg_1_0:com_registMsg(FightMsgId.GMDouQuQuSkip2IndexRound, arg_1_0._onGMDouQuQuSkip2IndexRound)
end

function var_0_0.onAwake(arg_2_0)
	return
end

function var_0_0._onEnterStage(arg_3_0, arg_3_1)
	return
end

function var_0_0._onExitStage(arg_4_0, arg_4_1)
	return
end

function var_0_0._onPlayDouQuQu(arg_5_0, arg_5_1)
	arg_5_0.douQuQuPlayMgr = arg_5_0.douQuQuPlayMgr or arg_5_0:newClass(FightDouQuQuPlayMgr)

	arg_5_0.douQuQuPlayMgr:_onPlayDouQuQu(arg_5_1)
end

function var_0_0._onGMDouQuQuSkip2IndexRound(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.douQuQuPlayMgr = arg_6_0.douQuQuPlayMgr or arg_6_0:newClass(FightDouQuQuPlayMgr)

	arg_6_0.douQuQuPlayMgr:_onGMDouQuQuSkip2IndexRound(arg_6_1, arg_6_2)
end

function var_0_0.onDestructor(arg_7_0)
	return
end

return var_0_0
