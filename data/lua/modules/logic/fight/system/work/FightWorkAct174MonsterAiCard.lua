module("modules.logic.fight.system.work.FightWorkAct174MonsterAiCard", package.seeall)

local var_0_0 = class("FightWorkAct174MonsterAiCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendMsg(FightMsgId.Act174MonsterAiCard)
	arg_1_0:onDone(true)
end

function var_0_0._onPlayCardOver(arg_2_0)
	return
end

return var_0_0
