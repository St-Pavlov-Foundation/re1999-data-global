module("modules.ugui.textmeshpro.TMPDynamicSizeTextMgr", package.seeall)

local var_0_0 = class("TMPDynamicSizeTextMgr")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.csharpInst = ZProj.LangTextDynamicSizeMgr.Instance

	arg_2_0.csharpInst:SetChangeSizeFunc(arg_2_0._changeSize, arg_2_0)
	arg_2_0.csharpInst:SetFilterRichTextFunc(arg_2_0._filterRichText, arg_2_0)
end

function var_0_0._changeSize(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0, iter_3_1 in (string.gmatch(arg_3_3, "<size=(%d+)>(.+)</size>")) do
		local var_3_0 = string.format("<size=%d>%s</size>", iter_3_0, iter_3_1)
		local var_3_1 = string.format("<size=%d>%s</size>", iter_3_0 * arg_3_2, iter_3_1)

		arg_3_3 = string.gsub(arg_3_3, var_3_0, var_3_1)
	end

	arg_3_1:SetText(arg_3_3)
end

function var_0_0._filterRichText(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:FilterRichTextCb(arg_4_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
