module("modules.logic.survival.view.handbook.SurvivalHandbookResultItem", package.seeall)

local var_0_0 = class("SurvivalHandbookResultItem", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.animGo = gohelper.findComponentAnim(arg_2_1)
	arg_2_0.imgEmpty = gohelper.findChild(arg_2_1, "#imgEmpty")
	arg_2_0.simage_ending = gohelper.findChildSingleImage(arg_2_1, "#normal/#simage_ending")
	arg_2_0.txt_title = gohelper.findChildTextMesh(arg_2_1, "#normal/Title/#txt_title")
	arg_2_0.txt_desc = gohelper.findChildTextMesh(arg_2_1, "#normal/#txt_desc")
	arg_2_0.empty = gohelper.findChild(arg_2_1, "#empty")
	arg_2_0.normal = gohelper.findChild(arg_2_1, "#normal")
end

function var_0_0.getAnimator(arg_3_0)
	return arg_3_0.animGo
end

function var_0_0.onStart(arg_4_0)
	return
end

function var_0_0.addEventListeners(arg_5_0)
	return
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.setData(arg_8_0, arg_8_1)
	arg_8_0.survivalHandbookMo = arg_8_1.mo

	gohelper.setActive(arg_8_0.empty, not arg_8_0.survivalHandbookMo.isUnlock)
	gohelper.setActive(arg_8_0.normal, arg_8_0.survivalHandbookMo.isUnlock)

	if arg_8_0.survivalHandbookMo.isUnlock then
		arg_8_0.txt_title.text = arg_8_0.survivalHandbookMo:getResultTitle()
		arg_8_0.txt_desc.text = arg_8_0.survivalHandbookMo:getResultDesc()

		arg_8_0.simage_ending:LoadImage(arg_8_0.survivalHandbookMo:getResultImage())
	end
end

function var_0_0.refresh(arg_9_0)
	return
end

return var_0_0
