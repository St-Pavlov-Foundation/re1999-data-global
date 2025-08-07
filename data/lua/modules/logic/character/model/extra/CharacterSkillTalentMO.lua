module("modules.logic.character.model.extra.CharacterSkillTalentMO", package.seeall)

local var_0_0 = class("CharacterSkillTalentMO")

function var_0_0.initMo(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.talentId
	arg_1_0.level = arg_1_1.level
	arg_1_0.co = arg_1_1
	arg_1_0.status = CharacterExtraEnum.SkillTreeNodeStatus.Normal
end

function var_0_0.getLevel(arg_2_0)
	return arg_2_0.level
end

function var_0_0.setStatus(arg_3_0, arg_3_1)
	arg_3_0.status = arg_3_1
end

function var_0_0.isLight(arg_4_0)
	return arg_4_0.status == CharacterExtraEnum.SkillTreeNodeStatus.Light
end

function var_0_0.isLock(arg_5_0)
	return arg_5_0.status == CharacterExtraEnum.SkillTreeNodeStatus.Lock
end

function var_0_0.isNormal(arg_6_0)
	return arg_6_0.status == CharacterExtraEnum.SkillTreeNodeStatus.Normal
end

function var_0_0.getIconPath(arg_7_0)
	return arg_7_0.co.icon
end

function var_0_0.getDesc(arg_8_0, arg_8_1)
	local var_8_0 = ""

	if not arg_8_0.co then
		return var_8_0
	end

	local var_8_1 = arg_8_1 == 0 and arg_8_0.co.desc or arg_8_0.co["desc" .. arg_8_1]

	if string.nilorempty(var_8_1) then
		return var_8_1
	end

	return var_8_1
end

function var_0_0.getFieldDesc(arg_9_0, arg_9_1)
	local var_9_0 = ""

	if not arg_9_0.co then
		return var_9_0
	end

	local var_9_1 = arg_9_1 == 0 and arg_9_0.co.fieldDesc or arg_9_0.co["fieldDesc" .. arg_9_1]

	if string.nilorempty(var_9_1) then
		return var_9_1
	end

	return var_9_1
end

function var_0_0.getFieldActivateDesc(arg_10_0, arg_10_1)
	local var_10_0 = ""

	if not arg_10_0.co then
		return var_10_0
	end

	local var_10_1 = arg_10_1 == 0 and arg_10_0.co.fieldActivateDesc or arg_10_0.co["fieldActivateDesc" .. arg_10_1]

	if string.nilorempty(var_10_1) then
		return var_10_1
	end

	return var_10_1
end

function var_0_0.getAdditionalFieldDesc(arg_11_0, arg_11_1)
	local var_11_0 = ""

	if not arg_11_0.co then
		return var_11_0
	end

	local var_11_1 = arg_11_1 == 0 and arg_11_0.co.additionalFieldDesc or arg_11_0.co["additionalFieldDesc" .. arg_11_1]

	if string.nilorempty(var_11_1) then
		return var_11_1
	end

	return var_11_1
end

function var_0_0.getLightNodeAdditionalDesc(arg_12_0, arg_12_1)
	if arg_12_0:isLight() then
		return arg_12_0:getAdditionalFieldDesc(arg_12_1)
	end
end

function var_0_0.getReplaceSkill(arg_13_0, arg_13_1)
	if not arg_13_0.co then
		return
	end

	local var_13_0 = arg_13_0.co["exchangeSkills" .. arg_13_1]

	if string.nilorempty(var_13_0) then
		return
	end

	return (GameUtil.splitString2(var_13_0, true, "|", "#"))
end

return var_0_0
