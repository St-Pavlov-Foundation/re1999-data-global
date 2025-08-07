module("modules.logic.character.model.extra.CharacterSkillTalentTreeMO", package.seeall)

local var_0_0 = class("CharacterSkillTalentTreeMO")

function var_0_0.initMo(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sub = arg_1_1
	arg_1_0._moList = BaseModel.New()

	local var_1_0 = {}

	if arg_1_2 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
			local var_1_1 = CharacterSkillTalentMO.New()

			var_1_1:initMo(iter_1_1)
			table.insert(var_1_0, var_1_1)
		end
	end

	arg_1_0._moList:setList(var_1_0)
end

function var_0_0.getTreeMoList(arg_2_0)
	return arg_2_0._moList:getList()
end

function var_0_0.getMoById(arg_3_0, arg_3_1)
	return arg_3_0._moList:getById(arg_3_1)
end

function var_0_0.getNodeMoByLevel(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._moList:getList()) do
		if iter_4_1.level == arg_4_1 then
			return iter_4_1
		end
	end
end

function var_0_0.isAllLight(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._moList:getList()) do
		if not iter_5_1:isLight() then
			return false
		end
	end

	return true
end

function var_0_0.getLightNodeAdditionalDesc(arg_6_0, arg_6_1)
	local var_6_0 = ""
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._moList:getList()) do
		local var_6_2 = iter_6_1:getLightNodeAdditionalDesc(arg_6_1)

		if not string.nilorempty(var_6_2) and var_6_1 < iter_6_1.level then
			var_6_0 = var_6_2
		end
	end

	return var_6_0
end

return var_0_0
