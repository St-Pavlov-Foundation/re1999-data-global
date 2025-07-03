module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceView", package.seeall)

local var_0_0 = class("DestinyStoneGiftPickChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goconfirm = gohelper.findChild(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._goconfirmgrey = gohelper.findChild(arg_1_0.viewGO, "#btn_confirm_grey")
	arg_1_0._btnconfirmgrey = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm_grey")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._scrollstone = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_stone")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnconfirmgrey:AddClickListener(arg_2_0._btnconfirmgreyOnClick, arg_2_0)
	arg_2_0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, arg_2_0.onStoneUpFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnconfirmgrey:RemoveClickListener()
	arg_3_0:removeEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, arg_3_0.onStoneUpFinish, arg_3_0)
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	local var_4_0 = DestinyStoneGiftPickChoiceListModel.instance:getCurrentSelectMo()

	if var_4_0 then
		var_4_0.heroMo.destinyStoneMo:setUpStoneId(var_4_0.stoneId)

		local var_4_1 = {
			heroMo = var_4_0.heroMo,
			stoneMo = var_4_0.stoneMo
		}

		ViewMgr.instance:openView(ViewName.CharacterDestinyStoneUpView, var_4_1)
	end
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnconfirmgreyOnClick(arg_6_0)
	GameFacade.showToast(ToastEnum.NoChoiceHeroStoneUp)
end

function var_0_0.onStoneUpFinish(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	DestinyStoneGiftPickChoiceListModel.instance:initList()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = DestinyStoneGiftPickChoiceListModel.instance:getCurrentSelectMo() ~= nil

	gohelper.setActive(arg_11_0._goconfirm, var_11_0)
	gohelper.setActive(arg_11_0._goconfirmgrey, not var_11_0)
end

function var_0_0.onClose(arg_12_0)
	DestinyStoneGiftPickChoiceListModel.instance:clearSelect()
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
