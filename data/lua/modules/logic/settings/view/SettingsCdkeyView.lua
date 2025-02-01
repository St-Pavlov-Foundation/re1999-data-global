module("modules.logic.settings.view.SettingsCdkeyView", package.seeall)

slot0 = class("SettingsCdkeyView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_leftbg")
	slot0._inputcdkey = gohelper.findChildTextMeshInputField(slot0.viewGO, "#input_cdkey")
	slot0._goplaceholdertext = gohelper.findChildText(slot0.viewGO, "#input_cdkey/Text Area/Placeholder")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_close")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_sure")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
	slot0._inputcdkey:AddOnEndEdit(slot0._onInputCdkeyEndEdit, slot0)
	slot0._inputcdkey:AddOnValueChanged(slot0._onValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
	slot0._inputcdkey:RemoveOnEndEdit()
	slot0._inputcdkey:RemoveOnValueChanged()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._inputcdkey:GetText()) then
		GameFacade.showToast(ToastEnum.SettingsCdkeyIsNull)

		return
	end

	PlayerRpc.instance:sendUseCdKeyRequset(slot1)
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	SLFramework.UGUI.UIClickListener.Get(slot0._inputcdkey.gameObject):AddClickListener(slot0._hidePlaceholderText, slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnUseCdkReplay, slot0.onUseCdkReplay, slot0)
end

function slot0._hidePlaceholderText(slot0)
	ZProj.UGUIHelper.SetColorAlpha(slot0._goplaceholdertext, 0)
end

function slot0._onValueChanged(slot0, slot1)
	if GameUtil.utf8len(slot1) > 50 then
		slot0._inputcdkey:SetText(GameUtil.utf8sub(slot1, 1, 50))
	end
end

function slot0._onInputCdkeyEndEdit(slot0)
	ZProj.UGUIHelper.SetColorAlpha(slot0._goplaceholdertext, 0.6)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onUseCdkReplay(slot0)
	slot0._inputcdkey:SetText("")
end

function slot0.onClose(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._inputcdkey.gameObject):RemoveClickListener()
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
