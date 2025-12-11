module("modules.logic.fight.model.data.FightHurtInfoData", package.seeall)

local var_0_0 = FightDataClass("FightHurtInfoData")

var_0_0.DamageType = {
	Damage = GameUtil.getEnumId(),
	OriginDamage = GameUtil.getEnumId(),
	AdditionalDamage = GameUtil.getEnumId()
}

function var_0_0.getDamageTypeByHurtEffect(arg_1_0)
	if arg_1_0 == FightEnum.EffectType.DAMAGE then
		return var_0_0.DamageType.Damage
	elseif arg_1_0 == FightEnum.EffectType.CRIT then
		return var_0_0.DamageType.Damage
	elseif arg_1_0 == FightEnum.EffectType.ORIGINDAMAGE then
		return var_0_0.DamageType.OriginDamage
	elseif arg_1_0 == FightEnum.EffectType.ORIGINCRIT then
		return var_0_0.DamageType.OriginDamage
	elseif arg_1_0 == FightEnum.EffectType.ADDITIONALDAMAGE then
		return var_0_0.DamageType.AdditionalDamage
	elseif arg_1_0 == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
		return var_0_0.DamageType.AdditionalDamage
	end
end

var_0_0.DamageFromType = {
	AbsorbHurt = 5,
	Skill = 1,
	Buff = 3,
	Additional = 4,
	ShareHurt = 6,
	SkillEffect = 2,
	NONE = 0
}

local var_0_1 = {
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}

function var_0_0.onConstructor(arg_2_0, arg_2_1)
	arg_2_0.damage = arg_2_1.damage
	arg_2_0.reduceHp = arg_2_1.reduceHp
	arg_2_0.reduceShield = arg_2_1.reduceShield
	arg_2_0.careerRestraint = arg_2_1.careerRestraint
	arg_2_0.critical = var_0_1[arg_2_1.hurtEffect]
	arg_2_0.assassinate = arg_2_1.assassinate
	arg_2_0.hurtEffect = arg_2_1.hurtEffect
	arg_2_0.damageFromType = arg_2_1.damageFromType
	arg_2_0.configEffect = arg_2_1.configEffect
	arg_2_0.buffActId = arg_2_1.buffActId
	arg_2_0.buffUid = arg_2_1.buffUid
	arg_2_0.effectId = arg_2_1.effectId
	arg_2_0.skillId = arg_2_1.skillId

	if arg_2_1:HasField("fromUid") then
		arg_2_0.fromUid = arg_2_1.fromUid
	end
end

function var_0_0.getFloatType(arg_3_0)
	local var_3_0 = var_0_0.getDamageTypeByHurtEffect(arg_3_0.hurtEffect)

	if var_3_0 == var_0_0.DamageType.Damage then
		if arg_3_0.skillId ~= 0 and arg_3_0.careerRestraint then
			return arg_3_0.critical and FightEnum.FloatType.crit_restrain or FightEnum.FloatType.restrain
		else
			return arg_3_0.critical and FightEnum.FloatType.crit_damage or FightEnum.FloatType.damage
		end
	end

	if var_3_0 == var_0_0.DamageType.OriginDamage then
		return arg_3_0.critical and FightEnum.FloatType.crit_damage_origin or FightEnum.FloatType.damage_origin
	end

	if var_3_0 == var_0_0.DamageType.AdditionalDamage then
		return arg_3_0.critical and FightEnum.FloatType.crit_additional_damage or FightEnum.FloatType.additional_damage
	end

	return FightEnum.FloatType.damage
end

return var_0_0
