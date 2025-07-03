module("modules.logic.versionactivity2_7.lengzhou6.model.skill.SkillBase", package.seeall)

local var_0_0 = class("SkillBase")

function var_0_0.ctor(arg_1_0)
	arg_1_0._id = 0
	arg_1_0._configId = 0
	arg_1_0._cd = 0
	arg_1_0._entity = nil
	arg_1_0._skillType = LengZhou6Enum.SkillType.passive
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._id = arg_2_1
	arg_2_0._configId = arg_2_2
	arg_2_0._config = LengZhou6Config.instance:getEliminateBattleSkill(arg_2_2)
	arg_2_0._cd = arg_2_0._config.cd

	arg_2_0:_initEffect()
end

function var_0_0.getConfig(arg_3_0)
	return arg_3_0._config
end

function var_0_0.getConfigId(arg_4_0)
	return arg_4_0._configId
end

function var_0_0._initEffect(arg_5_0)
	local var_5_0 = arg_5_0._config.effect

	arg_5_0._triggerPoint = arg_5_0._config.triggerPoint

	if not string.nilorempty(var_5_0) then
		arg_5_0._effect = string.split(var_5_0, "#")
	end
end

function var_0_0.getEffect(arg_6_0)
	return arg_6_0._effect
end

function var_0_0.initEntity(arg_7_0, arg_7_1)
	arg_7_0._entity = arg_7_1
end

function var_0_0.getEntityCamp(arg_8_0)
	if arg_8_0._entity then
		return arg_8_0._entity:getCamp()
	end

	return -1
end

function var_0_0.getSkillType(arg_9_0)
	return arg_9_0._skillType
end

function var_0_0.getCd(arg_10_0)
	return arg_10_0._cd
end

function var_0_0.setCd(arg_11_0, arg_11_1)
	arg_11_0._cd = arg_11_1

	if arg_11_0._cd < 0 then
		arg_11_0._cd = 0
	end
end

function var_0_0.updateCD(arg_12_0)
	arg_12_0._cd = arg_12_0._cd - 1

	if arg_12_0._cd < 0 then
		arg_12_0._cd = 0
	end
end

function var_0_0.execute(arg_13_0)
	if arg_13_0._cd == 0 then
		arg_13_0._cd = arg_13_0._config.cd

		return true
	end
end

return var_0_0
