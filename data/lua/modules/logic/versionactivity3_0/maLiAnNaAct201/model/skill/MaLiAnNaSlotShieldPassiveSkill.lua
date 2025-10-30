module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSlotShieldPassiveSkill", package.seeall)

local var_0_0 = class("MaLiAnNaSlotShieldPassiveSkill", MaLiAnNaSkillBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, nil)

	arg_1_0._skillType = Activity201MaLiAnNaEnum.SkillType.passive
	arg_1_0._effect = arg_1_2
	arg_1_0._startAngle = arg_1_0._effect[2]
	arg_1_0._angleRange = arg_1_0._effect[3]
	arg_1_0._hpMax = arg_1_0._effect[4]
	arg_1_0._hp = arg_1_0._effect[5] or 0
	arg_1_0._speed = arg_1_0._effect[6] or 1
	arg_1_0._hpUpCd = arg_1_0._effect[7] or 3000
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0._cd = math.max(0, arg_2_0._cd - arg_2_1)

	if arg_2_0._cd == 0 then
		arg_2_0:_updateHp(arg_2_0._speed * arg_2_1)
	end
end

function var_0_0.getAngleAndRange(arg_3_0)
	return arg_3_0._startAngle, arg_3_0._angleRange
end

function var_0_0.canUseSkill(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0:getHp() <= 0 then
		return false
	end

	if arg_4_1 == nil or arg_4_2 == nil then
		return false
	end

	local var_4_0 = arg_4_2:getMoveSlotPathPoint()[arg_4_2:getCurMoveIndex() - 1]

	if var_4_0 == nil or var_4_0 == 0 then
		return false
	end

	local var_4_1, var_4_2 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_4_0):getPosXY()
	local var_4_3, var_4_4 = arg_4_1:getPosXY()

	return (MathUtil.is_point_in_sector(var_4_1, var_4_2, var_4_3, var_4_4, 2000, arg_4_0._startAngle, arg_4_0._angleRange))
end

function var_0_0.soliderAttack(arg_5_0, arg_5_1)
	if arg_5_0._cd == 0 then
		arg_5_0._cd = arg_5_0._hpUpCd
	end

	arg_5_0:_updateHp(-arg_5_1)

	return arg_5_0:getHp() > 0
end

function var_0_0._updateHp(arg_6_0, arg_6_1)
	arg_6_0._hp = math.floor(math.min(arg_6_0._hpMax, math.max(arg_6_0._hp + arg_6_1, 0)))
end

function var_0_0.getHp(arg_7_0)
	return arg_7_0._hp
end

function var_0_0.destroy(arg_8_0)
	arg_8_0._soliderId = nil
	arg_8_0._config = nil
end

return var_0_0
