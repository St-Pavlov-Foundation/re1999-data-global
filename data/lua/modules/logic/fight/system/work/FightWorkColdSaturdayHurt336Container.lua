module("modules.logic.fight.system.work.FightWorkColdSaturdayHurt336Container", package.seeall)

local var_0_0 = class("FightWorkColdSaturdayHurt336Container", FightStepEffectFlow)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = {
		[FightEnum.EffectType.BUFFADD] = true,
		[FightEnum.EffectType.BUFFDEL] = true,
		[FightEnum.EffectType.BUFFUPDATE] = true,
		[FightEnum.EffectType.NONE] = true,
		[FightEnum.EffectType.DAMAGE] = true,
		[FightEnum.EffectType.CRIT] = true
	}

	arg_1_0:playAdjacentParallelEffect(var_1_0, true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
