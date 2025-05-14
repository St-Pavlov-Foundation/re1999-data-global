﻿module("modules.logic.fight.system.work.FightWorkDamageShareHp", package.seeall)

local var_0_0 = class("FightWorkDamageShareHp", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0._actEffectMO.targetId)

	if var_1_0 then
		local var_1_1 = arg_1_0._actEffectMO.effectNum

		if var_1_1 > 0 then
			if not var_1_0:isMySide() or not -var_1_1 then
				local var_1_2 = var_1_1
			end

			if var_1_0.nameUI then
				var_1_0.nameUI:addHp(-var_1_1)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_0, -var_1_1)
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
