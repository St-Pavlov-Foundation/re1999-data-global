-- chunkname: @modules/logic/fight/model/data/FightHurtInfoData.lua

module("modules.logic.fight.model.data.FightHurtInfoData", package.seeall)

local FightHurtInfoData = FightDataClass("FightHurtInfoData")

FightHurtInfoData.DamageType = {
	Damage = GameUtil.getEnumId(),
	OriginDamage = GameUtil.getEnumId(),
	AdditionalDamage = GameUtil.getEnumId()
}

function FightHurtInfoData.getDamageTypeByHurtEffect(hurtEffect)
	if hurtEffect == FightEnum.EffectType.DAMAGE then
		return FightHurtInfoData.DamageType.Damage
	elseif hurtEffect == FightEnum.EffectType.CRIT then
		return FightHurtInfoData.DamageType.Damage
	elseif hurtEffect == FightEnum.EffectType.ORIGINDAMAGE then
		return FightHurtInfoData.DamageType.OriginDamage
	elseif hurtEffect == FightEnum.EffectType.ORIGINCRIT then
		return FightHurtInfoData.DamageType.OriginDamage
	elseif hurtEffect == FightEnum.EffectType.ADDITIONALDAMAGE then
		return FightHurtInfoData.DamageType.AdditionalDamage
	elseif hurtEffect == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
		return FightHurtInfoData.DamageType.AdditionalDamage
	end
end

FightHurtInfoData.DamageFromType = {
	AbsorbHurt = 5,
	Skill = 1,
	Buff = 3,
	Additional = 4,
	ShareHurt = 6,
	SkillEffect = 2,
	NONE = 0
}

local criticalType = {
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}

function FightHurtInfoData:onConstructor(proto)
	self.damage = proto.damage
	self.reduceHp = proto.reduceHp
	self.reduceShield = proto.reduceShield
	self.careerRestraint = proto.careerRestraint
	self.critical = criticalType[proto.hurtEffect]
	self.assassinate = proto.assassinate
	self.hurtEffect = proto.hurtEffect
	self.damageFromType = proto.damageFromType
	self.configEffect = proto.configEffect
	self.buffActId = proto.buffActId
	self.buffUid = proto.buffUid
	self.effectId = proto.effectId
	self.skillId = proto.skillId

	if proto:HasField("fromUid") then
		self.fromUid = proto.fromUid
	end
end

function FightHurtInfoData:getFloatType()
	local damageType = FightHurtInfoData.getDamageTypeByHurtEffect(self.hurtEffect)

	if damageType == FightHurtInfoData.DamageType.Damage then
		local isRestrain = self.skillId ~= 0 and self.careerRestraint

		if isRestrain then
			return self.critical and FightEnum.FloatType.crit_restrain or FightEnum.FloatType.restrain
		else
			return self.critical and FightEnum.FloatType.crit_damage or FightEnum.FloatType.damage
		end
	end

	if damageType == FightHurtInfoData.DamageType.OriginDamage then
		return self.critical and FightEnum.FloatType.crit_damage_origin or FightEnum.FloatType.damage_origin
	end

	if damageType == FightHurtInfoData.DamageType.AdditionalDamage then
		return self.critical and FightEnum.FloatType.crit_additional_damage or FightEnum.FloatType.additional_damage
	end

	return FightEnum.FloatType.damage
end

return FightHurtInfoData
