module("modules.logic.character.config.CharacterExtraConfig", package.seeall)

local var_0_0 = class("CharacterExtraConfig")

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"hero3124_skill_talent",
		"fight_eziozhuangbei",
		"fight_eziozhuangbei_icon"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "hero3124_skill_talent" then
		arg_3_0:_initSkillTalentConfig(arg_3_2)
	elseif arg_3_1 == "fight_eziozhuangbei" then
		arg_3_0._ezioWeaponGroupConfig = arg_3_2
	elseif arg_3_1 == "fight_eziozhuangbei_icon" then
		arg_3_0:_initEzioWeaponConfig(arg_3_2)
	end
end

function var_0_0._initSkillTalentConfig(arg_4_0, arg_4_1)
	arg_4_0._skillTalentCo = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		if not arg_4_0._skillTalentCo[iter_4_1.sub] then
			arg_4_0._skillTalentCo[iter_4_1.sub] = {}
		end

		arg_4_0._skillTalentCo[iter_4_1.sub][iter_4_1.level] = iter_4_1
	end
end

function var_0_0.getSkillTalentCoBySubLevel(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._skillTalentCo[arg_5_1]

	return var_5_0 and var_5_0[arg_5_2]
end

function var_0_0.getSkillTalentCoById(arg_6_0, arg_6_1)
	return lua_hero3124_skill_talent.configDict[arg_6_1]
end

function var_0_0.getSkillTalentCos(arg_7_0)
	return arg_7_0._skillTalentCo
end

function var_0_0.getEzioWeaponGroupConfigTable(arg_8_0)
	return arg_8_0._ezioWeaponGroupConfig
end

function var_0_0.getEzioWeaponGroupCos(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._ezioWeaponGroupConfig then
		return
	end

	local var_9_0 = arg_9_0._ezioWeaponGroupConfig.configDict[arg_9_1]

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0[arg_9_2]

	if not var_9_1 then
		return
	end

	return var_9_1[arg_9_3]
end

function var_0_0._initEzioWeaponConfig(arg_10_0, arg_10_1)
	arg_10_0._ezioWeaponConfig = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.configList) do
		if not arg_10_0._ezioWeaponConfig[iter_10_1.type] then
			arg_10_0._ezioWeaponConfig[iter_10_1.type] = {}
		end

		table.insert(arg_10_0._ezioWeaponConfig[iter_10_1.type], iter_10_1)
	end
end

function var_0_0.getEzioWeaponCosByType(arg_11_0, arg_11_1)
	return arg_11_0._ezioWeaponConfig[arg_11_1]
end

function var_0_0.getEzioWeaponCoById(arg_12_0, arg_12_1)
	return lua_fight_eziozhuangbei_icon.configDict[arg_12_1]
end

function var_0_0.getEzioWeaponConfigs(arg_13_0)
	return arg_13_0._ezioWeaponConfig
end

var_0_0.instance = var_0_0.New()

return var_0_0
