module("modules.logic.character.model.extra.CharacterWeaponListModel", package.seeall)

local var_0_0 = class("CharacterWeaponListModel", MixScrollModel)

function var_0_0.setMoList(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:getMoList(arg_1_1)

	arg_1_0:setList(var_1_0)
end

function var_0_0.getMoList(arg_2_0, arg_2_1)
	local var_2_0 = CharacterExtraConfig.instance:getEzioWeaponGroupConfigTable().configList
	local var_2_1 = {}
	local var_2_2 = arg_2_1.exSkillLevel

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.secondId ~= 0 and iter_2_1.skillLevel == var_2_2 then
			local var_2_3 = CharacterWeaponEffectMO.New()

			var_2_3:initMo(iter_2_1)
			table.insert(var_2_1, var_2_3)
		end
	end

	return var_2_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
