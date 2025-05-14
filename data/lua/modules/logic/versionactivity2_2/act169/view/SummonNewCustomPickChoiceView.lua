module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceView", package.seeall)

local var_0_0 = class("SummonNewCustomPickChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagedecbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg/#simage_decbg")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._scrollrule = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rule")
	arg_1_0._goexskill = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill/#image_exskill")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/select/#go_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0:addEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, arg_2_0.handleCusomPickCompleted, arg_2_0)
	arg_2_0:addEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0:removeEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, arg_3_0.handleCusomPickCompleted, arg_3_0)
	arg_3_0:removeEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	SummonNewCustomPickChoiceController.instance:trySendChoice()
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = SummonNewCustomPickChoiceListModel.instance:getSelectCount()
	local var_8_1 = SummonNewCustomPickChoiceListModel.instance:getMaxSelectCount()

	ZProj.UGUIHelper.SetGrayscale(arg_8_0._btnconfirm.gameObject, var_8_0 ~= var_8_1)
end

function var_0_0.onClose(arg_9_0)
	SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
end

function var_0_0.handleCusomPickCompleted(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
