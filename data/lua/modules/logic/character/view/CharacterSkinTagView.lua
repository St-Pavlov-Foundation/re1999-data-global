module("modules.logic.character.view.CharacterSkinTagView", package.seeall)

slot0 = class("CharacterSkinTagView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "bg/#scroll_prop")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._btnplay = gohelper.findChildButton(slot0.viewGO, "bg/#btn_play")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnplay:AddClickListener(slot0._btnplayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnplay:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._skinCo = slot0.viewParam.skinCo

	recthelper.setHeight(slot0._gobg.transform, math.min(#string.splitToNumber(slot0._skinCo.storeTag, "|") * 62 + 120, 400))
	gohelper.setActive(slot0._btnplay, not VersionValidator.instance:isInReviewing() and slot0._skinCo.isSkinVideo)
	CharacterSkinTagListModel.instance:updateList(slot0._skinCo)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._btnplayOnClick(slot0)
	slot3 = WebViewController.instance:getVideoUrl(slot0._skinCo.characterId, slot0._skinCo.id)

	if UnityEngine.Application.version == "2.2.0" and GameChannelConfig.isLongCheng() and BootNativeUtil.isAndroid() then
		UnityEngine.Application.OpenURL(slot3)

		return
	end

	WebViewController.instance:openWebView(slot3, false, slot0.OnWebViewBack, slot0)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
end

function slot0.OnWebViewBack(slot0, slot1, slot2)
	if slot1 == WebViewEnum.WebViewCBType.Cb and slot2 == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end

	logNormal("URL Jump Callback msg" .. slot2)
end

function slot0.onDestroyView(slot0)
end

return slot0
