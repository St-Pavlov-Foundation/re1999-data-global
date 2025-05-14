module("modules.logic.season.view.SeasonEquipSelfChoiceView", package.seeall)

local var_0_0 = class("SeasonEquipSelfChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg2")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/mask/#scroll_item")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "root/mask/#scroll_item/viewport/itemcontent/#go_carditem")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_ok")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnclose1OnClick(arg_4_0)
	return
end

function var_0_0._btnokOnClick(arg_5_0)
	Activity104EquipSelfChoiceController.instance:sendSelectCard(arg_5_0.handleSendChoice, arg_5_0)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_7_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagebg1:UnLoadImage()
	arg_8_0._simagebg2:UnLoadImage()
	Activity104EquipSelfChoiceController.instance:onCloseView()
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam.actId
	local var_9_1 = arg_9_0.viewParam.costItemUid

	if not Activity104EquipSelfChoiceController:checkOpenParam(var_9_0, var_9_1) then
		arg_9_0:delayClose()

		return
	end

	Activity104EquipSelfChoiceController.instance:onOpenView(var_9_0, var_9_1)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.closeThis, arg_10_0)
end

function var_0_0.delayClose(arg_11_0)
	TaskDispatcher.runDelay(arg_11_0.closeThis, arg_11_0, 0.001)
end

function var_0_0.handleSendChoice(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 ~= 0 then
		return
	end

	arg_12_0:closeThis()

	if arg_12_0.viewParam.successCall then
		arg_12_0.viewParam.successCall(arg_12_0.viewParam.successCallObj)
	end
end

return var_0_0
