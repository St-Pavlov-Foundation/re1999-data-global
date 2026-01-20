-- chunkname: @modules/logic/fight/system/work/FightWorkEffectDamage.lua

module("modules.logic.fight.system.work.FightWorkEffectDamage", package.seeall)

local FightWorkEffectDamage = class("FightWorkEffectDamage", FightEffectBase)

function FightWorkEffectDamage:onStart()
	if self.actEffectData.custom_nuoDiKaDamageSign then
		self:com_sendFightEvent(FightEvent.OnCurrentHpChange, self.actEffectData.targetId)
		self:onDone(true)

		return
	end

	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local effectNum = self.actEffectData.effectNum

		if effectNum > 0 then
			local floatNum = entity:isMySide() and -effectNum or effectNum
			local floatType = self:getFloatType()

			if self.actEffectData.configEffect == 30006 then
				floatType = FightEnum.FloatType.damage
			end

			FightFloatMgr.instance:float(entity.id, floatType, floatNum, nil, self.actEffectData.effectNum1 == 1)

			if entity.nameUI then
				entity.nameUI:addHp(-effectNum)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
		end
	end

	self:onDone(true)
end

function FightWorkEffectDamage:getFloatType()
	local isRestrain = FightHelper.isRestrain(self.fightStepData.fromId, self.actEffectData.targetId)

	if self.actEffectData.hurtInfo then
		isRestrain = self.actEffectData.hurtInfo.careerRestraint
	end

	local isOppositeSide = FightHelper.isOppositeByEntityId(self.fightStepData.fromId, self.actEffectData.targetId)

	if isRestrain and isOppositeSide then
		if self.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
			return FightEnum.FloatType.restrain
		elseif self.actEffectData.effectType == FightEnum.EffectType.CRIT then
			return FightEnum.FloatType.crit_restrain
		end
	elseif self.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
		return FightEnum.FloatType.damage
	elseif self.actEffectData.effectType == FightEnum.EffectType.CRIT then
		return FightEnum.FloatType.crit_damage
	end

	return FightEnum.FloatType.damage
end

return FightWorkEffectDamage
