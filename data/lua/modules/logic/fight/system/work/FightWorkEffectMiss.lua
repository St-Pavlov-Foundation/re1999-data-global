﻿module("modules.logic.fight.system.work.FightWorkEffectMiss", package.seeall)

local var_0_0 = class("FightWorkEffectMiss", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightHelper.getEntity(arg_1_0._actEffectMO.targetId) then
		FightFloatMgr.instance:float(arg_1_0._actEffectMO.targetId, FightEnum.FloatType.buff, luaLang("fight_float_miss"), FightEnum.BuffFloatEffectType.Good)
	end

	arg_1_0:onDone(true)
end

return var_0_0
