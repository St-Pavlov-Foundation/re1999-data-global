module("modules.logic.fight.system.work.FightWorkPlayerFinisherSkillChange", package.seeall)

local var_0_0 = class("FightWorkPlayerFinisherSkillChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendMsg(FightMsgId.RefreshPlayerFinisherSkill)
	arg_1_0:onDone(true)
end

return var_0_0
