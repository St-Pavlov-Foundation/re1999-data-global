module("modules.logic.fight.system.work.FightWorkEffectImmunity", package.seeall)

local var_0_0 = class("FightWorkEffectImmunity", BaseWork)

function var_0_0.onStart(arg_1_0)
	FightFloatMgr.instance:float(arg_1_0._actEffectMO.targetId, FightEnum.FloatType.buff, luaLang("fight_buff_reject"), FightEnum.BuffFloatEffectType.Good)
	arg_1_0:onDone(true)
end

return var_0_0
