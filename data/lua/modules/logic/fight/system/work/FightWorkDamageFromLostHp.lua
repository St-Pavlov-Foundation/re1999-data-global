﻿module("modules.logic.fight.system.work.FightWorkDamageFromLostHp", package.seeall)

local var_0_0 = class("FightWorkDamageFromLostHp", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0._actEffectMO.targetId)

	if var_1_0 then
		local var_1_1 = arg_1_0._actEffectMO.effectNum

		if var_1_1 > 0 then
			local var_1_2 = var_1_0:isMySide() and -var_1_1 or var_1_1

			FightFloatMgr.instance:float(var_1_0.id, FightEnum.FloatType.damage, var_1_2)

			if var_1_0.nameUI then
				var_1_0.nameUI:addHp(-var_1_1)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_0, -var_1_1)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
