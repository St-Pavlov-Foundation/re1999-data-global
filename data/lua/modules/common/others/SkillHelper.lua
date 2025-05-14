module("modules.common.others.SkillHelper", package.seeall)

local var_0_0 = class("SkillHelper")

function var_0_0.getTagDescRecursion(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or "#6680bd"

	local var_1_0 = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(arg_1_0)
	local var_1_1 = ""
	local var_1_2 = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_3 = SkillConfig.instance:getSkillEffectDescCo(var_1_0[iter_1_0])

		if var_1_3 then
			local var_1_4 = var_1_3.name

			if (not var_1_3.notAddLink or var_1_3.notAddLink == 0) and not var_1_2[var_1_4] then
				var_1_2[var_1_4] = true

				local var_1_5 = var_0_0.buildDesc(var_1_3.desc)

				if LangSettings.instance:isEn() then
					var_1_1 = var_1_1 .. string.format("<color=%s>[%s]</color>: %s\n", arg_1_1, var_1_4, var_1_5)
				else
					var_1_1 = var_1_1 .. string.format("<color=%s>[%s]</color>:%s\n", arg_1_1, var_1_4, var_1_5)
				end
			end
		end
	end

	return var_1_1
end

function var_0_0.addHyperLinkClick(arg_2_0, arg_2_1, arg_2_2)
	if gohelper.isNil(arg_2_0) then
		logError("textComp is nil, please check !!!")

		return
	end

	gohelper.onceAddComponent(arg_2_0, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_2_1 or var_0_0.defaultClick, arg_2_2)
end

function var_0_0.defaultClick(arg_3_0, arg_3_1)
	CommonBuffTipController.instance:openCommonTipView(arg_3_0, arg_3_1)
end

function var_0_0.getSkillDesc(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = FightConfig.instance:getSkillEffectDesc(arg_4_0, arg_4_1)

	return var_0_0.buildDesc(var_4_0, arg_4_2, arg_4_3)
end

function var_0_0.buildDesc(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0 = var_0_0.addLink(arg_5_0)
	arg_5_0 = var_0_0.addColor(arg_5_0, arg_5_1, arg_5_2)

	return arg_5_0
end

function var_0_0.getEntityDescBySkillCo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = FightConfig.instance:getEntityName(arg_6_0)

	return var_0_0.getSkillDesc(var_6_0, arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.getEntityDescBySkillId(arg_7_0, arg_7_1)
	local var_7_0 = lua_skill.configDict[arg_7_1]

	if not var_7_0 then
		logError("技能表找不到id : " .. tostring(arg_7_1))

		return ""
	end

	local var_7_1 = FightConfig.instance:getEntityName(arg_7_0)

	return var_0_0.getSkillDesc(var_7_1, var_7_0)
end

function var_0_0.addColor(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0 = var_0_0.addNumColor(arg_8_0, arg_8_1)
	arg_8_0 = var_0_0.addBracketColor(arg_8_0, arg_8_2)

	return arg_8_0
end

function var_0_0.addBracketColor(arg_9_0, arg_9_1)
	if string.nilorempty(arg_9_1) then
		arg_9_1 = "#4e6698"
	end

	local var_9_0 = var_0_0.getColorFormat(arg_9_1, "%1")

	arg_9_0 = string.gsub(arg_9_0, "%[.-%]", var_9_0)
	arg_9_0 = string.gsub(arg_9_0, "【.-】", var_9_0)

	return arg_9_0
end

function var_0_0.addNumColor(arg_10_0, arg_10_1)
	if string.nilorempty(arg_10_1) then
		arg_10_1 = "#C66030"
	end

	local var_10_0 = var_0_0.getColorFormat(arg_10_1, "%1")

	arg_10_0 = string.gsub(arg_10_0, "[+-]?%d+%.%d+%%", var_10_0)
	arg_10_0 = string.gsub(arg_10_0, "[+-]?%d+%%", var_10_0)

	return arg_10_0
end

function var_0_0.getColorFormat(arg_11_0, arg_11_1)
	return string.format("<color=%s>%s</color>", arg_11_0, arg_11_1)
end

function var_0_0.addLink(arg_12_0)
	arg_12_0 = string.gsub(arg_12_0, "%[(.-)%]", var_0_0._replaceDescTagFunc1)
	arg_12_0 = string.gsub(arg_12_0, "【(.-)】", var_0_0._replaceDescTagFunc2)

	return arg_12_0
end

function var_0_0._replaceDescTagFunc1(arg_13_0)
	local var_13_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_13_0)

	arg_13_0 = var_0_0.removeRichTag(arg_13_0)

	if not var_13_0 then
		return string.format("[%s]", arg_13_0)
	end

	if not var_13_0.notAddLink or var_13_0.notAddLink == 0 then
		return string.format("[<u><link=%s>%s</link></u>]", var_13_0.id, arg_13_0)
	end

	return string.format("[%s]", arg_13_0)
end

function var_0_0._replaceDescTagFunc2(arg_14_0)
	local var_14_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_14_0)

	arg_14_0 = var_0_0.removeRichTag(arg_14_0)

	if not var_14_0 then
		return string.format("【%s】", arg_14_0)
	end

	if not var_14_0.notAddLink or var_14_0.notAddLink == 0 then
		return string.format("【<u><link=%s>%s</link></u>】", var_14_0.id, arg_14_0)
	end

	return string.format("【%s】", arg_14_0)
end

function var_0_0.removeRichTag(arg_15_0)
	return string.gsub(arg_15_0, "<.->", "")
end

function var_0_0.canShowTag(arg_16_0)
	return arg_16_0 and (not arg_16_0.notAddLink or arg_16_0.notAddLink == 0)
end

return var_0_0
