module("modules.logic.playercard.view.PlayerCardCharacterSwitchTipsView", package.seeall)

local var_0_0 = class("PlayerCardCharacterSwitchTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntouchClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_touchClose")
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_tipbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_buy")
	arg_1_0._toggletip = gohelper.findChildToggle(arg_1_0.viewGO, "centerTip/#toggle_tip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntouchClose:AddClickListener(arg_2_0._btntouchCloseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._toggletip:AddOnValueChanged(arg_2_0._toggleTipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntouchClose:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._toggletip:RemoveOnValueChanged()
end

function var_0_0._btntouchCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	if arg_5_0._toggletip.isOn then
		PlayerCardModel.instance:setCharacterSwitchFlag(false)
	end

	PlayerCardCharacterSwitchListModel.instance:changeMainHeroByParam(arg_5_0.characterParam, false)
	arg_5_0:closeThis()
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function var_0_0._btnbuyOnClick(arg_6_0)
	if arg_6_0._toggletip.isOn then
		PlayerCardModel.instance:setCharacterSwitchFlag(true)
	end

	PlayerCardCharacterSwitchListModel.instance:changeMainHeroByParam(arg_6_0.characterParam, true)
	arg_6_0:closeThis()
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function var_0_0._toggleTipOnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._toggletip.isOn = false

	arg_8_0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	arg_10_0.characterParam = arg_10_0.viewParam.heroParam

	NavigateMgr.instance:addEscape(arg_10_0.viewName, arg_10_0._btncloseOnClick, arg_10_0)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagetipbg:UnLoadImage()
end

return var_0_0
