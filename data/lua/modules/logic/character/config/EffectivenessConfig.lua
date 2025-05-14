module("modules.logic.character.config.EffectivenessConfig", package.seeall)

local var_0_0 = class("EffectivenessConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.subValue = 0.7
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"hero_effectiveness",
		"equip_effectiveness",
		"talent_effectiveness",
		"talent_scheme"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

var_0_0.HeroRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}
var_0_0.EquipRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}

function var_0_0.calculateHeroEffectiveness(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = lua_hero_effectiveness.configDict[arg_4_1.level]
	local var_4_1 = arg_4_1.config
	local var_4_2

	if var_4_1.rare == var_0_0.HeroRareRareEnum.SSR then
		var_4_2 = var_4_0.ssr
	elseif var_4_1.rare == var_0_0.HeroRareRareEnum.SR then
		var_4_2 = var_4_0.sr
	else
		var_4_2 = var_4_0.r
	end

	if arg_4_2 then
		return var_4_2 * arg_4_0.subValue
	end

	return var_4_2
end

function var_0_0.calculateHeroAverageEffectiveness(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = 0

	for iter_5_0 = 1, #arg_5_1 do
		var_5_0 = var_5_0 + arg_5_0:calculateHeroEffectiveness(arg_5_1[iter_5_0])
	end

	for iter_5_1 = 1, #arg_5_2 do
		var_5_0 = var_5_0 + arg_5_0:calculateHeroEffectiveness(arg_5_2[iter_5_1], true)
	end

	return var_5_0 / (#arg_5_1 + #arg_5_2)
end

function var_0_0.calculateEquipEffectiveness(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = lua_equip_effectiveness.configDict[arg_6_1.level]
	local var_6_1 = arg_6_1.config
	local var_6_2

	if var_6_1.rare == var_0_0.EquipRareRareEnum.SSR then
		var_6_2 = var_6_0.ssr
	elseif var_6_1.rare == var_0_0.EquipRareRareEnum.SR then
		var_6_2 = var_6_0.sr
	else
		var_6_2 = var_6_0.r
	end

	if arg_6_2 then
		return var_6_2 * arg_6_0.subValue
	end

	return var_6_2
end

function var_0_0.calculateEquipAverageEffectiveness(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_0 == 4 then
			var_7_0 = var_7_0 + arg_7_0:calculateEquipEffectiveness(iter_7_1, true)
		else
			var_7_0 = var_7_0 + arg_7_0:calculateEquipEffectiveness(iter_7_1)
		end
	end

	return #arg_7_1 ~= 0 and var_7_0 / #arg_7_1 or 0
end

function var_0_0.calculateTalentEffectiveness(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = lua_talent_effectiveness.configDict[arg_8_1.talent]
	local var_8_1 = arg_8_1.config
	local var_8_2

	if var_8_1.rare == var_0_0.HeroRareRareEnum.SSR then
		var_8_2 = var_8_0.ssr
	elseif var_8_1.rare == var_0_0.HeroRareRareEnum.SR then
		var_8_2 = var_8_0.sr
	else
		var_8_2 = var_8_0.r
	end

	if arg_8_2 then
		return var_8_2 * arg_8_0.subValue
	end

	return var_8_2
end

function var_0_0.calculateTalentAverageEffectiveness(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_1 do
		var_9_0 = var_9_0 + arg_9_0:calculateTalentEffectiveness(arg_9_1[iter_9_0])
	end

	for iter_9_1 = 1, #arg_9_2 do
		var_9_0 = var_9_0 + arg_9_0:calculateTalentEffectiveness(arg_9_2[iter_9_1], true)
	end

	return var_9_0 / (#arg_9_1 + #arg_9_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
