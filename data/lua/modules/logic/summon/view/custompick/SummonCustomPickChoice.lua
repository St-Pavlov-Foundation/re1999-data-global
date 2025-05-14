module("modules.logic.summon.view.custompick.SummonCustomPickChoice", package.seeall)

local var_0_0 = class("SummonCustomPickChoice", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Tips2/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	SummonCustomPickChoiceController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	logNormal("SummonCustomPickChoice onOpen")
	arg_6_0:addEventCb(SummonController.instance, SummonEvent.onCustomPicked, arg_6_0.handleCusomPickCompleted, arg_6_0)
	arg_6_0:addEventCb(SummonCustomPickChoiceController.instance, SummonEvent.onCustomPickListChanged, arg_6_0.refreshUI, arg_6_0)
	SummonCustomPickChoiceController.instance:onOpenView(arg_6_0.viewParam.poolId)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0._btnokOnClick(arg_8_0)
	SummonCustomPickChoiceController.instance:trySendChoice()
end

function var_0_0._btncancelOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._btnbgOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = SummonCustomPickChoiceListModel.instance:getSelectCount()
	local var_11_1 = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()

	arg_11_0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		var_11_0,
		var_11_1
	})

	ZProj.UGUIHelper.SetGrayscale(arg_11_0._btnok.gameObject, var_11_0 ~= var_11_1)
end

function var_0_0.handleCusomPickCompleted(arg_12_0)
	arg_12_0:closeThis()
end

return var_0_0
