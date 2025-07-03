module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueCountExSkill", package.seeall)

local var_0_0 = class("FightWorkRedOrBlueCountExSkill", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightStrUtil.instance:getSplitToNumberCache(arg_1_0.actEffectData.reserveStr, "#")

	if not var_1_0 then
		return arg_1_0:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.LY_TriggerCountSkill, var_1_0[1], var_1_0[2], tonumber(arg_1_0.actEffectData.reserveId))

	return arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
