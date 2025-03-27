module("modules.logic.playercard.view.PlayerCardCharacterSwitchTipsView", package.seeall)

slot0 = class("PlayerCardCharacterSwitchTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btntouchClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_touchClose")
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_tipbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_buy")
	slot0._toggletip = gohelper.findChildToggle(slot0.viewGO, "centerTip/#toggle_tip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntouchClose:AddClickListener(slot0._btntouchCloseOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._toggletip:AddOnValueChanged(slot0._toggleTipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntouchClose:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._toggletip:RemoveOnValueChanged()
end

function slot0._btntouchCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	if slot0._toggletip.isOn then
		PlayerCardModel.instance:setCharacterSwitchFlag(false)
	end

	PlayerCardCharacterSwitchListModel.instance:changeMainHeroByParam(slot0.characterParam, false)
	slot0:closeThis()
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function slot0._btnbuyOnClick(slot0)
	if slot0._toggletip.isOn then
		PlayerCardModel.instance:setCharacterSwitchFlag(true)
	end

	PlayerCardCharacterSwitchListModel.instance:changeMainHeroByParam(slot0.characterParam, true)
	slot0:closeThis()
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function slot0._toggleTipOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._editableInitView(slot0)
	slot0._toggletip.isOn = false

	slot0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	slot0.characterParam = slot0.viewParam.heroParam

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagetipbg:UnLoadImage()
end

return slot0
