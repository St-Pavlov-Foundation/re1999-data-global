module("modules.logic.fight.system.work.FightWorkEffectGuardBreak", package.seeall)

local var_0_0 = class("FightWorkEffectGuardBreak", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 and var_1_0.effect then
		local var_1_1 = 0.5
		local var_1_2 = var_1_0.effect:addHangEffect("buff/buff_podun", ModuleEnum.SpineHangPoint.mountmiddle, nil, var_1_1)

		var_1_2:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_1_0.id, var_1_2)
		arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_1)
		AudioMgr.instance:trigger(410000102)

		return
	end

	arg_1_0:onDone(true)
end

return var_0_0
