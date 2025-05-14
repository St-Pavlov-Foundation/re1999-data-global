module("modules.logic.versionactivity2_5.liangyue.view.LiangYueAttributeDescItem", package.seeall)

local var_0_0 = class("LiangYueAttributeDescItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txt_Num = gohelper.findChildText(arg_1_1, "#txt_Num")
	arg_1_0._txt_NumChanged = gohelper.findChildText(arg_1_1, "#txt_Num1")
end

function var_0_0.setActive(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0.go, arg_2_1)
end

function var_0_0.setInfo(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = string.format("%s%s", LiangYueEnum.CalculateSymbol[arg_3_1], arg_3_2)

	arg_3_0._txt_Num.text = var_3_0

	if arg_3_0._txt_NumChanged then
		arg_3_0._txt_NumChanged.text = var_3_0
	end
end

function var_0_0.setTargetInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = string.format("%s/%s", arg_4_1, arg_4_2)

	arg_4_0._txt_Num.text = var_4_0

	if arg_4_0._txt_NumChanged then
		arg_4_0._txt_NumChanged.text = var_4_0
	end

	arg_4_0:setTxtColor(arg_4_3)
end

function var_0_0.setTxtColor(arg_5_0, arg_5_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._txt_Num, arg_5_1)

	if arg_5_0._txt_NumChanged then
		SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._txt_NumChanged, arg_5_1)
	end
end

return var_0_0
