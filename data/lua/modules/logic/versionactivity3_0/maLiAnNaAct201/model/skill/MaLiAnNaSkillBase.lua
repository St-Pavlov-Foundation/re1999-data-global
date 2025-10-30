module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSkillBase", package.seeall)

local var_0_0 = class("MaLiAnNaSkillBase")

function var_0_0.ctor(arg_1_0)
	arg_1_0._id = 0
	arg_1_0._configId = 0
	arg_1_0._cdTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._id = arg_2_1
	arg_2_0._configId = arg_2_2

	arg_2_0:_initEffect()
end

function var_0_0.getConfig(arg_3_0)
	return arg_3_0._config
end

function var_0_0.getConfigId(arg_4_0)
	return arg_4_0._configId
end

function var_0_0._initEffect(arg_5_0)
	if arg_5_0._config == nil then
		return
	end

	local var_5_0 = arg_5_0._config.effect

	if not string.nilorempty(var_5_0) then
		arg_5_0._effect = string.splitToNumber(var_5_0, "#")
	end
end

function var_0_0.getSkillActionType(arg_6_0)
	if arg_6_0._effect == nil then
		return nil
	end

	return arg_6_0._effect[1]
end

function var_0_0.getEffect(arg_7_0)
	return arg_7_0._effect
end

function var_0_0.getSkillType(arg_8_0)
	return arg_8_0._skillType
end

function var_0_0.getCdTime(arg_9_0)
	return arg_9_0._cdTime
end

function var_0_0.update(arg_10_0, arg_10_1)
	if arg_10_0._cdTime <= 0 then
		return true
	end

	arg_10_0._cdTime = math.max(arg_10_0._cdTime - arg_10_1 * 1000, 0)

	return false
end

function var_0_0.execute(arg_11_0)
	return
end

return var_0_0
