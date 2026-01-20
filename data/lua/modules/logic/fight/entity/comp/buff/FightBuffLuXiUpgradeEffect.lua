-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffLuXiUpgradeEffect.lua

module("modules.logic.fight.entity.comp.buff.FightBuffLuXiUpgradeEffect", package.seeall)

local FightBuffLuXiUpgradeEffect = class("FightBuffLuXiUpgradeEffect", FightBaseClass)

function FightBuffLuXiUpgradeEffect:onConstructor(entity, entityData, luxiUpgradeEffectConfig)
	local effectType = 1

	for k, v in pairs(luxiUpgradeEffectConfig) do
		effectType = v.effectType

		break
	end

	local class = effectType == 1 and FightBuffLuXiUpgradeEffect1 or FightBuffLuXiUpgradeEffect2

	self:newClass(class, entity, entityData, luxiUpgradeEffectConfig)
end

return FightBuffLuXiUpgradeEffect
