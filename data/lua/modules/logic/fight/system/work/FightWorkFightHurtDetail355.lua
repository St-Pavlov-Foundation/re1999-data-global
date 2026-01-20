-- chunkname: @modules/logic/fight/system/work/FightWorkFightHurtDetail355.lua

module("modules.logic.fight.system.work.FightWorkFightHurtDetail355", package.seeall)

local FightWorkFightHurtDetail355 = class("FightWorkFightHurtDetail355", FightEffectBase)
local type2class = {
	[FightEnum.EffectType.KILL] = FightWorkKill110,
	[FightEnum.EffectType.DAMAGEFROMABSORB] = FightWorkDamageFromAbsorb192
}

FightWorkFightHurtDetail355.DamageEffectClass = type2class

local type2ParallelEffect = {
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = FightWorkDeadlyPoisonOriginDamage263Parallel,
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = FightWorkDeadlyPoisonOriginCrit264Parallel,
	[FightEnum.EffectType.COLDSATURDAYHURT] = FightWorkColdSaturdayHurt336Parallel
}

setmetatable(type2ParallelEffect, {
	__index = type2class
})

function FightWorkFightHurtDetail355:onStart()
	local hurtInfo = self.actEffectData.hurtInfo
	local effectType = hurtInfo.effectType
	local class = type2ParallelEffect[effectType]

	if not class then
		local entityId = self.actEffectData.targetId
		local entity = FightHelper.getEntity(entityId)

		if entity then
			local hurtDamage = hurtInfo.damage
			local reduceHp = hurtInfo.reduceHp
			local floatNum = entity:isMySide() and -hurtDamage or hurtDamage
			local floatType = hurtInfo:getFloatType()

			FightFloatMgr.instance:float(entityId, floatType, floatNum, nil, hurtInfo.assassinate)

			if entity.nameUI then
				entity.nameUI:addHp(-reduceHp)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -reduceHp)
		end

		FightMsgMgr.sendMsg(FightMsgId.EntityHurt, entityId, hurtInfo)

		return self:onDone(true)
	end

	local flow = self:com_registFlowSequence()

	flow:registWork(class, self.actEffectData)
	self:playWorkAndDone(flow)
end

return FightWorkFightHurtDetail355
