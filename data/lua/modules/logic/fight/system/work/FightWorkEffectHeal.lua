module("modules.logic.fight.system.work.FightWorkEffectHeal", package.seeall)

local var_0_0 = class("FightWorkEffectHeal", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not arg_1_0.actEffectData then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 then
		if not var_1_0.nameUI then
			arg_1_0:onDone(true)

			return
		end

		local var_1_1 = var_1_0.nameUI:getHp()
		local var_1_2 = arg_1_0.actEffectData.effectNum
		local var_1_3 = arg_1_0.actEffectData.effectType == FightEnum.EffectType.HEALCRIT and FightEnum.FloatType.crit_heal or FightEnum.FloatType.heal

		FightFloatMgr.instance:float(var_1_0.id, var_1_3, var_1_2)
		var_1_0.nameUI:addHp(var_1_2)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_0, var_1_2)

		local var_1_4 = var_1_0.nameUI:getHp()

		if var_1_1 <= 0 and var_1_4 > 0 and not FightSkillMgr.instance:isPlayingAnyTimeline() then
			var_1_0.nameUI:setActive(true)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
