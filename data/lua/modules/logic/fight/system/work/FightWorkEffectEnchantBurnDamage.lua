module("modules.logic.fight.system.work.FightWorkEffectEnchantBurnDamage", package.seeall)

local var_0_0 = class("FightWorkEffectEnchantBurnDamage", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 then
		local var_1_1 = arg_1_0.actEffectData.effectNum

		if var_1_1 > 0 then
			local var_1_2 = var_1_0:isMySide() and -var_1_1 or var_1_1

			FightFloatMgr.instance:float(var_1_0.id, FightEnum.FloatType.damage, var_1_2, nil, arg_1_0.actEffectData.effectNum1 == 1)

			if var_1_0.nameUI then
				var_1_0.nameUI:addHp(-var_1_1)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_0, -var_1_1)

			local var_1_3 = var_1_0.effect:addHangEffect("buff/buff_shenghuo", "mountbody", nil, 1.5 / FightModel.instance:getSpeed())

			FightAudioMgr.instance:playAudio(4307301)
			FightRenderOrderMgr.instance:onAddEffectWrap(var_1_0.id, var_1_3)
			var_1_3:setLocalPos(0, 0, 0)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
