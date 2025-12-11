module("modules.logic.necrologiststory.common.NecrologistStoryHelper", package.seeall)

local var_0_0 = class("NecrologistStoryHelper")

function var_0_0.addHyperLinkClick(arg_1_0, arg_1_1, arg_1_2)
	if gohelper.isNil(arg_1_0) then
		logError("textComp is nil, please check !!!")

		return
	end

	gohelper.onceAddComponent(arg_1_0, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_1_1 or var_0_0.defaultClick, arg_1_2)
end

function var_0_0.defaultClick(arg_2_0, arg_2_1)
	NecrologistStoryController.instance:openTipView(arg_2_0, arg_2_1)
end

function var_0_0.getDesc(arg_3_0, arg_3_1)
	local var_3_0 = NecrologistStoryConfig.instance:getStoryConfig(arg_3_0)

	return var_0_0.getDescByConfig(var_3_0, arg_3_1)
end

function var_0_0.getDescByConfig(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.desc

	return var_0_0.buildDesc(var_4_0, arg_4_1)
end

function var_0_0.buildDesc(arg_5_0, arg_5_1)
	local var_5_0 = false

	arg_5_0 = var_0_0.addColor(arg_5_0, arg_5_1)

	local var_5_1

	arg_5_0, var_5_1 = var_0_0.addLink(arg_5_0)

	return arg_5_0, var_5_1
end

function var_0_0.addLink(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = false
	local var_6_2

	arg_6_0, var_6_2 = string.gsub(arg_6_0, "%[(.-)%]", var_0_0._replaceDescTagFunc1)

	local var_6_3 = var_6_2 ~= 0
	local var_6_4

	arg_6_0, var_6_4 = string.gsub(arg_6_0, "【(.-)】", var_0_0._replaceDescTagFunc2)

	if var_6_4 ~= 0 then
		var_6_3 = true
	end

	return arg_6_0, var_6_3
end

function var_0_0._replaceDescTagFunc1(arg_7_0)
	local var_7_0 = NecrologistStoryConfig.instance:getIntroduceCoByName(arg_7_0)

	arg_7_0 = var_0_0.removeRichTag(arg_7_0)

	if not var_7_0 then
		return arg_7_0
	end

	if not var_7_0.notAddLink or var_7_0.notAddLink == 0 then
		return string.format("<u><link=%s>%s</link></u>", var_7_0.id, arg_7_0)
	end

	return arg_7_0
end

function var_0_0._replaceDescTagFunc2(arg_8_0)
	local var_8_0 = NecrologistStoryConfig.instance:getIntroduceCoByName(arg_8_0)

	arg_8_0 = var_0_0.removeRichTag(arg_8_0)

	if not var_8_0 then
		return arg_8_0
	end

	if not var_8_0.notAddLink or var_8_0.notAddLink == 0 then
		return string.format("<u><link=%s>%s</link></u>", var_8_0.id, arg_8_0)
	end

	return arg_8_0
end

function var_0_0.removeRichTag(arg_9_0)
	return string.gsub(arg_9_0, "<.->", "")
end

function var_0_0.loadSituationFunc(arg_10_0)
	local var_10_0 = string.format("return %s", arg_10_0)
	local var_10_1, var_10_2 = loadstring(var_10_0)

	if not var_10_1 then
		logError(string.format("条件表达式错误 表达式:%s error:%s", arg_10_0, var_10_2))
	end

	return var_10_1
end

function var_0_0.addColor(arg_11_0, arg_11_1)
	arg_11_0 = var_0_0.addBracketColor(arg_11_0, arg_11_1)

	return arg_11_0
end

function var_0_0.addBracketColor(arg_12_0, arg_12_1)
	if string.nilorempty(arg_12_1) then
		arg_12_1 = "#AE5D30"
	end

	local var_12_0 = var_0_0.getColorFormat(arg_12_1, "%1")

	arg_12_0 = string.gsub(arg_12_0, "%[.-%]", var_12_0)
	arg_12_0 = string.gsub(arg_12_0, "【.-】", var_12_0)

	return arg_12_0
end

function var_0_0.getColorFormat(arg_13_0, arg_13_1)
	return string.format("<color=%s>%s</color>", arg_13_0, arg_13_1)
end

function var_0_0.getTimeFormat(arg_14_0)
	local var_14_0 = math.floor(arg_14_0)
	local var_14_1 = math.floor((arg_14_0 - var_14_0) * 60)
	local var_14_2 = var_14_0 >= 12 and "PM" or "AM"
	local var_14_3 = var_14_0 % 12

	if var_14_3 == 0 then
		var_14_3 = 12
	end

	return var_14_3, var_14_1, var_14_2
end

function var_0_0.getTimeFormat2(arg_15_0)
	local var_15_0 = math.floor(arg_15_0)
	local var_15_1 = math.floor((arg_15_0 - var_15_0) * 60)

	return var_15_0 % 24, var_15_1
end

var_0_0.DialogNameTag = "{roleName}"

function var_0_0.getDialogName(arg_16_0)
	local var_16_0 = arg_16_0.name

	if string.match(var_16_0, var_0_0.DialogNameTag) then
		local var_16_1 = NecrologistStoryConfig.instance:getPlotGroupCo(arg_16_0.storygroup)

		return true, string.gsub(var_16_0, var_0_0.DialogNameTag, var_16_1.roleName)
	end

	return false, var_16_0
end

return var_0_0
