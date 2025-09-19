module("modules.logic.versionactivity2_8.act199.view.V2a8_SelfSelectSix_PickChoiceView", package.seeall)

local var_0_0 = class("V2a8_SelfSelectSix_PickChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Tips2/#txt_num")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._scrollrule = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rule")
	arg_1_0._trsscrollrule = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule").transform
	arg_1_0._trscontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/Content").transform

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0:addEventCb(V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0:removeEventCb(V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	V2a8_SelfSelectSix_PickChoiceController.instance:tryChoice(arg_4_0.viewParam)
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshSelectCount()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshSelectCount()
end

function var_0_0._onCloseView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.CharacterGetView then
		arg_10_0:closeThis()
	end
end

function var_0_0.refreshSelectCount(arg_11_0)
	local var_11_0 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	local var_11_1 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()

	arg_11_0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		var_11_0,
		var_11_1
	})

	ZProj.UGUIHelper.SetGrayscale(arg_11_0._btnconfirm.gameObject, var_11_0 ~= var_11_1)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
