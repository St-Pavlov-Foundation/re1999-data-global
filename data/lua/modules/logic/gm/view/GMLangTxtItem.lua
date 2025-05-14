module("modules.logic.gm.view.GMLangTxtItem", package.seeall)

local var_0_0 = class("GMLangTxtItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txt = gohelper.findChildText(arg_1_1, "txt")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_1)

	arg_1_0._click:AddClickListener(arg_1_0._onClick, arg_1_0)
end

function var_0_0.removeEventListeners(arg_2_0)
	arg_2_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0._data = arg_3_1.txt
	arg_3_0._txt.text = arg_3_1.txt
end

function var_0_0._onClick(arg_4_0)
	arg_4_0._view.viewContainer:onLangTxtClick(arg_4_0._data)
end

return var_0_0
