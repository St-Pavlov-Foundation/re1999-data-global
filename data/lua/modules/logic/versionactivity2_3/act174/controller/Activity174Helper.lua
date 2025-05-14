module("modules.logic.versionactivity2_3.act174.controller.Activity174Helper", package.seeall)

local var_0_0 = class("Activity174Helper")

function var_0_0.MatchKeyInArray(arg_1_0, arg_1_1, arg_1_2)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		if iter_1_1[arg_1_2] == arg_1_1 then
			return iter_1_1
		end
	end
end

function var_0_0.CalculateRowColumn(arg_2_0)
	local var_2_0 = math.ceil(arg_2_0 / 4)
	local var_2_1 = arg_2_0 % 4

	var_2_1 = var_2_1 ~= 0 and var_2_1 or 4

	return var_2_0, var_2_1
end

function var_0_0.sortActivity174RoleCo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.type == Activity174Enum.CharacterType.Hero

	if var_3_0 ~= (arg_3_1.type == Activity174Enum.CharacterType.Hero) then
		return var_3_0
	end

	if arg_3_0.rare ~= arg_3_1.rare then
		return arg_3_0.rare > arg_3_1.rare
	end

	return arg_3_0.heroId < arg_3_1.heroId
end

function var_0_0.getEmptyFightEntityMO(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = FightEntityMO.New()

	var_4_0.id = tostring(arg_4_0)
	var_4_0.uid = var_4_0.id
	var_4_0.modelId = arg_4_1.heroId or 0
	var_4_0.entityType = 1
	var_4_0.exPoint = 0
	var_4_0.side = FightEnum.EntitySide.MySide
	var_4_0.currentHp = 0
	var_4_0.attrMO = FightHelper._buildAttr(arg_4_1)
	var_4_0.skillIds = var_0_0.buildRoleSkills(arg_4_1)
	var_4_0.shieldValue = 0
	var_4_0.level = 1
	var_4_0.skin = arg_4_1.skinId

	return var_4_0
end

function var_0_0.buildRoleSkills(arg_5_0)
	local var_5_0 = {}

	if arg_5_0 then
		local var_5_1 = string.splitToNumber(arg_5_0.passiveSkill, "|")

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			var_5_0[#var_5_0 + 1] = iter_5_1
		end

		local var_5_2 = string.splitToNumber(arg_5_0.activeSkill1, "#")

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			var_5_0[#var_5_0 + 1] = iter_5_3
		end

		local var_5_3 = string.splitToNumber(arg_5_0.activeSkill2, "#")

		for iter_5_4, iter_5_5 in ipairs(var_5_3) do
			var_5_0[#var_5_0 + 1] = iter_5_5
		end

		var_5_0[#var_5_0 + 1] = arg_5_0.uniqueSkill
	end

	return var_5_0
end

return var_0_0
