module("modules.logic.fight.entity.comp.specialeffect.FightEntityCustomSpecialEffect", package.seeall)

slot0 = class("FightEntityCustomSpecialEffect", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	slot0:registClass(FightEntitySpecialEffectBuffLayerEnemySkin)

	for slot5, slot6 in pairs(FightDataHelper.entityMgr:getAllEntityMO()) do
		if slot6.modelId == 3079 then
			slot0:registClass(FightEntitySpecialEffect3079_Buff)

			break
		end
	end

	slot0:registClass(FightEntitySpecialEffect3070_Ball)
	slot0:registClass(FightEntitySpecialEffectBuffLayer)
	slot0:registClass(FightEntitySpecialEffect3081_Ball)
	slot0:registClass(FightEntitySpecialEffectSeasonChangeHero)
	slot0:registClass(FightEntitySpecialEffectBuffLayerNaNa)
end

return slot0
