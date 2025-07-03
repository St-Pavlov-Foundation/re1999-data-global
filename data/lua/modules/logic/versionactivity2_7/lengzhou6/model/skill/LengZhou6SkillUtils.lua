module("modules.logic.versionactivity2_7.lengzhou6.model.skill.LengZhou6SkillUtils", package.seeall)

local var_0_0 = class("LengZhou6SkillUtils")
local var_0_1 = {}
local var_0_2 = 0

function var_0_0.createSkill(arg_1_0)
	local var_1_0 = LengZhou6Config.instance:getEliminateBattleSkill(arg_1_0)

	if var_1_0 == nil then
		logError("skillConfig is nil, configId = " .. arg_1_0)

		return nil
	end

	local var_1_1

	if var_0_1[arg_1_0] == nil then
		if var_1_0.type == LengZhou6Enum.SkillType.enemyActive then
			var_1_1 = EnemyGeneralSkill.New()
		end

		if var_1_0.type == LengZhou6Enum.SkillType.active then
			var_1_1 = PlayerActiveSkill.New()
		end

		if var_1_0.type == LengZhou6Enum.SkillType.passive then
			var_1_1 = GeneralSkill.New()
		end
	else
		var_1_1 = var_0_1[arg_1_0].New()
	end

	var_1_1:init(var_0_2, arg_1_0)

	var_0_2 = var_0_2 + 1

	return var_1_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
