module("modules.logic.commonbufftip.CommonBuffTipController", package.seeall)

local var_0_0 = class("CommonBuffTipController")

function var_0_0.initViewParam(arg_1_0)
	arg_1_0.viewParam = arg_1_0.viewParam or {}

	tabletool.clear(arg_1_0.viewParam)
end

function var_0_0.openCommonTipView(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:initViewParam()

	arg_2_0.viewParam.effectId = arg_2_1
	arg_2_0.viewParam.clickPosition = arg_2_2

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, arg_2_0.viewParam)
end

function var_0_0.openCommonTipViewWithCustomPos(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:initViewParam()

	arg_3_0.viewParam.effectId = arg_3_1
	arg_3_0.viewParam.scrollAnchorPos = arg_3_2
	arg_3_0.viewParam.pivot = arg_3_3 or CommonBuffTipEnum.Pivot.Left

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, arg_3_0.viewParam)
end

function var_0_0.openCommonTipViewWithCustomPosCallback(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:initViewParam()

	arg_4_0.viewParam.effectId = arg_4_1
	arg_4_0.viewParam.setScrollPosCallback = arg_4_2
	arg_4_0.viewParam.setScrollPosCallbackObj = arg_4_3

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, arg_4_0.viewParam)
end

function var_0_0.getBuffTagName(arg_5_0, arg_5_1)
	local var_5_0 = string.match(arg_5_1, "<id:(%d+)>")
	local var_5_1 = tonumber(var_5_0)

	if var_5_1 then
		return arg_5_0:getBuffTagNameByBuffId(var_5_1, arg_5_1)
	end

	return arg_5_0:getBuffTagNameByBuffName(arg_5_1)
end

function var_0_0.getBuffTagNameByBuffId(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 and lua_skill_buff.configDict[arg_6_1]
	local var_6_1 = SkillHelper.removeRichTag(arg_6_2)

	if var_6_0 and var_6_0.name == var_6_1 then
		return arg_6_0:getBuffTagNameByTypeId(var_6_0.typeId)
	end

	return arg_6_0:getBuffTagNameByBuffName(arg_6_2)
end

function var_0_0.getBuffTagNameByBuffName(arg_7_0, arg_7_1)
	arg_7_1 = SkillHelper.removeRichTag(arg_7_1)

	if string.nilorempty(arg_7_1) then
		return ""
	end

	for iter_7_0, iter_7_1 in ipairs(lua_skill_buff.configList) do
		if iter_7_1.name == arg_7_1 then
			return arg_7_0:getBuffTagNameByTypeId(iter_7_1.typeId)
		end
	end

	return ""
end

function var_0_0.getBuffTagNameByTypeId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 and lua_skill_bufftype.configDict[arg_8_1]
	local var_8_1 = var_8_0 and lua_skill_buff_desc.configDict[var_8_0.type]

	if var_8_1 and var_8_1.id ~= 9 then
		return var_8_1.name
	end

	return ""
end

var_0_0.instance = var_0_0.New()

return var_0_0
