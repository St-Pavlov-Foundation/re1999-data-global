module("modules.logic.fight.system.work.FightWorkEffectShieldDel", package.seeall)

local var_0_0 = class("FightWorkEffectShieldDel", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 and var_1_0.nameUI then
		var_1_0.nameUI:setShield(0)
	end

	if var_1_0 then
		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, var_1_0, 0)
	end

	arg_1_0:onDone(true)
end

return var_0_0
