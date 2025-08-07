module("modules.logic.character.model.extra.CharacterExtraMO", package.seeall)

local var_0_0 = class("CharacterExtraMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.heroMo = arg_1_1
end

function var_0_0.refreshMo(arg_2_0, arg_2_1)
	arg_2_0._extra = {}

	if arg_2_0:hasTalentSkill() then
		arg_2_0._skillTalentMo = arg_2_0._skillTalentMo or CharacterExtraSkillTalentMO.New()

		arg_2_0._skillTalentMo:refreshMo(arg_2_1, arg_2_0.heroMo)
	end

	if arg_2_0:hasWeapon() then
		arg_2_0._weaponMo = arg_2_0._weaponMo or CharacterExtraWeaponMO.New()

		arg_2_0._weaponMo:refreshMo(arg_2_1, arg_2_0.heroMo)
	end
end

function var_0_0.hasTalentSkill(arg_3_0)
	return arg_3_0.heroMo.heroId == 3124
end

function var_0_0.hasWeapon(arg_4_0)
	return arg_4_0.heroMo.heroId == 3123
end

function var_0_0.getSkillTalentMo(arg_5_0)
	return arg_5_0._skillTalentMo
end

function var_0_0.getWeaponMo(arg_6_0)
	return arg_6_0._weaponMo
end

function var_0_0.showReddot(arg_7_0)
	if arg_7_0._skillTalentMo then
		return arg_7_0._skillTalentMo:showReddot()
	end

	if arg_7_0._weaponMo then
		for iter_7_0, iter_7_1 in ipairs(CharacterExtraEnum.WeaponParams) do
			if arg_7_0._weaponMo:isShowWeaponReddot(iter_7_0) then
				return true
			end
		end
	end
end

function var_0_0.getReplaceSkills(arg_8_0, arg_8_1)
	if arg_8_0._weaponMo then
		arg_8_1 = arg_8_0._weaponMo:getReplacePassiveSkills(arg_8_1)
	end

	if arg_8_0._skillTalentMo then
		arg_8_1 = arg_8_0._skillTalentMo:getReplaceSkills(arg_8_1)
	end

	return arg_8_1
end

return var_0_0
