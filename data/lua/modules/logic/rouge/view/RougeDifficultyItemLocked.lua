module("modules.logic.rouge.view.RougeDifficultyItemLocked", package.seeall)

local var_0_0 = class("RougeDifficultyItemLocked", RougeDifficultyItem_Base)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBg1 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg1")
	arg_1_0._goBg2 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg2")
	arg_1_0._goBg3 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg3")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num1")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num2")
	arg_1_0._txtnum3 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num3")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_en")

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

	arg_4_0._txtLocked = gohelper.findChildText(arg_4_0.viewGO, "lock/txt_locked")
end

function var_0_0.setData(arg_5_0, arg_5_1)
	RougeDifficultyItem_Base.setData(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_1.difficultyCO.preDifficulty

	if var_5_0 and var_5_0 > 0 then
		local var_5_1 = RougeOutsideModel.instance:config():getDifficultyCO(var_5_0)

		arg_5_0._txtLocked.text = formatLuaLang("rougedifficultyitemlocked_unlock_desc_fmt", var_5_1.title)
	else
		arg_5_0._txtLocked.text = ""
	end
end

return var_0_0
