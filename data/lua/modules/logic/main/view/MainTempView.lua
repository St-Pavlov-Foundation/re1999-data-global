module("modules.logic.main.view.MainTempView", package.seeall)

local var_0_0 = class("MainTempView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnrouge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rouge")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrouge:AddClickListener(arg_2_0._btnRougeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrouge:RemoveClickListener()
end

function var_0_0._btnRougeOnClick(arg_4_0)
	RougeController.instance:enterRouge()
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0._onCloseView(arg_6_0)
	return
end

return var_0_0
