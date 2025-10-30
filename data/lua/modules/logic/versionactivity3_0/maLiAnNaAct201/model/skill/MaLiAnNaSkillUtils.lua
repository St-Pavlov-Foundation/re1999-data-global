module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSkillUtils", package.seeall)

local var_0_0 = class("MaLiAnNaSkillUtils")
local var_0_1 = 0

function var_0_0.createSkill(arg_1_0)
	local var_1_0

	if Activity201MaLiAnNaConfig.instance:getActiveSkillConfig(arg_1_0) == nil then
		local var_1_1 = Activity201MaLiAnNaConfig.instance:getPassiveSkillConfig(arg_1_0)

		var_1_0 = MaLiAnNaPassiveSkill.New()
	else
		var_1_0 = MaLiAnNaActiveSkill.New()
	end

	if var_1_0 ~= nil then
		var_1_0:init(var_0_1, arg_1_0)

		var_0_1 = var_0_1 + 1
	end

	return var_1_0
end

function var_0_0.createSkillBySlotType(arg_2_0)
	if string.nilorempty(arg_2_0) then
		return nil
	end

	local var_2_0 = string.splitToNumber(arg_2_0, "#")

	if #var_2_0 < 2 then
		return nil
	end

	local var_2_1 = var_2_0[1]

	if var_2_1 == Activity201MaLiAnNaEnum.SlotType.trench then
		local var_2_2 = MaLiAnNaSlotShieldPassiveSkill.New()

		var_2_0[1] = Activity201MaLiAnNaEnum.SkillAction.slotShield

		var_2_2:init(var_0_1, var_2_0)

		var_0_1 = var_0_1 + 1

		return var_2_2
	end

	if var_2_1 == Activity201MaLiAnNaEnum.SlotType.bunker then
		local var_2_3 = MaLiAnNaSlotKillSoliderPassiveSkill.New()

		var_2_0[1] = Activity201MaLiAnNaEnum.SkillAction.killSolider

		var_2_3:init(var_0_1, var_2_0)

		var_0_1 = var_0_1 + 1

		return var_2_3
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
