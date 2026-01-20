-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntityCustomSpecialEffect.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntityCustomSpecialEffect", package.seeall)

local FightEntityCustomSpecialEffect = class("FightEntityCustomSpecialEffect", FightEntitySpecialEffectBase)

function FightEntityCustomSpecialEffect:initClass()
	self:newClass(FightEntitySpecialEffectBuffLayerEnemySkin)

	local entityDic = FightDataHelper.entityMgr:getAllEntityMO()

	for k, v in pairs(entityDic) do
		if v.modelId == 3079 then
			self:newClass(FightEntitySpecialEffect3079_Buff)

			break
		end
	end

	self:newClass(FightEntitySpecialEffect3070_Ball)
	self:newClass(FightEntitySpecialEffectBuffLayer)
	self:newClass(FightEntitySpecialEffectBuffLayerEnemySkin)
	self:newClass(FightEntitySpecialEffect3081_Ball)
	self:newClass(FightEntitySpecialEffectSeasonChangeHero)
	self:newClass(FightEntitySpecialEffectBuffLayerNaNa)
	self:newClass(FightEntitySpecialEffectBuffLayerLZL)
end

return FightEntityCustomSpecialEffect
