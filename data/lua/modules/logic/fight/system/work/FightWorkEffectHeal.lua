-- chunkname: @modules/logic/fight/system/work/FightWorkEffectHeal.lua

module("modules.logic.fight.system.work.FightWorkEffectHeal", package.seeall)

local FightWorkEffectHeal = class("FightWorkEffectHeal", FightEffectBase)

function FightWorkEffectHeal:onStart()
	if not self.actEffectData then
		self:onDone(true)

		return
	end

	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		if not entity.nameUI then
			self:onDone(true)

			return
		end

		local prevHp = entity.nameUI:getHp()
		local effectNum = self.actEffectData.effectNum
		local floatType = self.actEffectData.effectType == FightEnum.EffectType.HEALCRIT and FightEnum.FloatType.crit_heal or FightEnum.FloatType.heal

		FightFloatMgr.instance:float(entity.id, floatType, effectNum, nil, self.actEffectData.effectNum1 == 1)
		entity.nameUI:addHp(effectNum)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, effectNum)

		local nowHp = entity.nameUI:getHp()

		if prevHp <= 0 and nowHp > 0 and not FightSkillMgr.instance:isPlayingAnyTimeline() then
			entity.nameUI:setActive(true)
		end
	end

	self:onDone(true)
end

return FightWorkEffectHeal
