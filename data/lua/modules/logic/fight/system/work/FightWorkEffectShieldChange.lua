﻿module("modules.logic.fight.system.work.FightWorkEffectShieldChange", package.seeall)

local var_0_0 = class("FightWorkEffectShieldChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0._actEffectMO.targetId)
	local var_1_1 = arg_1_0._actEffectMO.effectNum

	if var_1_0 and var_1_0.nameUI and var_1_1 > 0 then
		var_1_0.nameUI:addHp(var_1_1)
		var_1_0.nameUI:setShield(0)
		FightFloatMgr.instance:float(var_1_0.id, FightEnum.FloatType.heal, var_1_1)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_0, var_1_1)
		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, var_1_0, 0)
	end

	arg_1_0:onDone(true)
end

return var_0_0
