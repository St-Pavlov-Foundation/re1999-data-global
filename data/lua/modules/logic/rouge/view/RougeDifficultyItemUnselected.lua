module("modules.logic.rouge.view.RougeDifficultyItemUnselected", package.seeall)

local var_0_0 = class("RougeDifficultyItemUnselected", RougeDifficultyItem_Base)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBg1 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg1")
	arg_1_0._goBg2 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg2")
	arg_1_0._goBg3 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg3")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num1")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num2")
	arg_1_0._txtnum3 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num3")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_en")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._txtScrollDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#txt_ScrollDesc")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	RougeDifficultyItem_Base._editableInitView(arg_4_0)

	arg_4_0._scrolldescLimitScrollRectCmp = arg_4_0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	arg_4_0:_onSetScrollParentGameObject(arg_4_0._scrolldescLimitScrollRectCmp)
end

function var_0_0.onDestroyView(arg_5_0)
	RougeDifficultyItem_Base.onDestroyView(arg_5_0)
end

function var_0_0.setData(arg_6_0, arg_6_1)
	RougeDifficultyItem_Base.setData(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_1.difficultyCO

	arg_6_0._txtScrollDesc.text = var_6_0.desc
end

return var_0_0
