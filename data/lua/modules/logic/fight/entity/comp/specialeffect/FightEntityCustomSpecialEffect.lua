module("modules.logic.fight.entity.comp.specialeffect.FightEntityCustomSpecialEffect", package.seeall)

local var_0_0 = class("FightEntityCustomSpecialEffect", FightEntitySpecialEffectBase)

function var_0_0.initClass(arg_1_0)
	arg_1_0:newClass(FightEntitySpecialEffectBuffLayerEnemySkin)

	local var_1_0 = FightDataHelper.entityMgr:getAllEntityMO()

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_1.modelId == 3079 then
			arg_1_0:newClass(FightEntitySpecialEffect3079_Buff)

			break
		end
	end

	arg_1_0:newClass(FightEntitySpecialEffect3070_Ball)
	arg_1_0:newClass(FightEntitySpecialEffectBuffLayer)
	arg_1_0:newClass(FightEntitySpecialEffect3081_Ball)
	arg_1_0:newClass(FightEntitySpecialEffectSeasonChangeHero)
	arg_1_0:newClass(FightEntitySpecialEffectBuffLayerNaNa)
end

return var_0_0
