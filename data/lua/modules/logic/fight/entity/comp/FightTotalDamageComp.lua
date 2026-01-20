-- chunkname: @modules/logic/fight/entity/comp/FightTotalDamageComp.lua

module("modules.logic.fight.entity.comp.FightTotalDamageComp", package.seeall)

local FightTotalDamageComp = class("FightTotalDamageComp", LuaCompBase)

function FightTotalDamageComp:ctor(entity)
	self.entity = entity
	self._damageDict = {}
end

function FightTotalDamageComp:init(go)
	FightController.instance:registerCallback(FightEvent.OnDamageTotal, self._onDamageTotal, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
end

function FightTotalDamageComp:removeEventListeners()
	FightController.instance:unregisterCallback(FightEvent.OnDamageTotal, self._onDamageTotal, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	TaskDispatcher.cancelTask(self._showTotalFloat, self)
end

function FightTotalDamageComp:_onDamageTotal(fightStepData, defender, damage, isLastHit)
	if defender == self.entity and damage and damage > 0 then
		self._damageDict[fightStepData] = self._damageDict[fightStepData] or {}

		table.insert(self._damageDict[fightStepData], damage)

		if isLastHit then
			self._damageDict[fightStepData].showTotal = true
			self._damageDict[fightStepData].fromId = fightStepData.fromId

			TaskDispatcher.runDelay(self._showTotalFloat, self, 0.6)
		end
	end
end

function FightTotalDamageComp:_onSkillPlayFinish(entity, skillId, fightStepData)
	if entity ~= self.entity and fightStepData.actType == FightEnum.ActType.SKILL then
		TaskDispatcher.cancelTask(self._showTotalFloat, self)

		if self._damageDict[fightStepData] then
			self._damageDict[fightStepData].showTotal = true
			self._damageDict[fightStepData].fromId = fightStepData.fromId
		end

		self:_showTotalFloat()
	end
end

local DMGTypes = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}
local ShieldTypes = {
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function FightTotalDamageComp:_showTotalFloat()
	for fightStepData, data in pairs(self._damageDict) do
		local show = data.showTotal and #data > 1

		if fightStepData.forceShowDamageTotalFloat then
			show = true
		end

		if show then
			local hasOrigin = false
			local hasAssassinate = false
			local floatNum = 0

			for _, actEffectData in ipairs(fightStepData.actEffect) do
				if actEffectData.targetId == self.entity.id then
					local et = actEffectData.effectType

					if FightTLEventDefHit.originHitEffectType[et] then
						hasOrigin = true
					end

					if actEffectData.effectNum1 == 1 then
						hasAssassinate = true
					end
				end
			end

			for _, actEffectData in ipairs(fightStepData.actEffect) do
				if actEffectData.targetId == self.entity.id then
					local et = actEffectData.effectType

					if DMGTypes[et] then
						floatNum = floatNum + actEffectData.effectNum

						if actEffectData.effectNum1 == 1 then
							hasAssassinate = true
						end
					elseif ShieldTypes[et] then
						floatNum = 0

						for _, damage in ipairs(data) do
							floatNum = floatNum + damage
						end

						if actEffectData.effectNum1 == 1 then
							hasAssassinate = true
						end

						break
					end
				end
			end

			if floatNum > 0 then
				local param = {}

				param.fromId = data.fromId
				param.defenderId = self.entity.id

				if self._fixedPos then
					param.pos_x = self._fixedPos[1]
					param.pos_y = self._fixedPos[2]
				end

				local floatType = hasOrigin and FightEnum.FloatType.total_origin or FightEnum.FloatType.total

				FightFloatMgr.instance:float(self.entity.id, floatType, floatNum, param, hasAssassinate)
			end
		end

		if data.showTotal then
			self._damageDict[fightStepData] = nil
		end
	end
end

return FightTotalDamageComp
