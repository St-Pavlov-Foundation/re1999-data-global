module("modules.logic.character.view.CharacterSkinTagView", package.seeall)

slot0 = class("CharacterSkinTagView", BaseView)
slot0.MAX_TAG_HEIGHT = 825

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "bg/#scroll_prop")
	slot0._btnplay = gohelper.findChildButton(slot0.viewGO, "bg/#go_btnRoot/#btn_play")
	slot0._gocontentroot = gohelper.findChild(slot0.viewGO, "bg/#scroll_prop/Viewport/Content")
	slot0._goviewport = gohelper.findChild(slot0.viewGO, "bg/#scroll_prop/Viewport")
	slot0._goitem = gohelper.findChild(slot0._gocontentroot, "item")

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
	slot0._itemList = {}
	slot0._bgLayoutElement = gohelper.onceAddComponent(slot0._gobg, typeof(UnityEngine.UI.LayoutElement))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._skinCo = slot0.viewParam.skinCo

	recthelper.setHeight(slot0._gobg.transform, math.min(#string.splitToNumber(slot0._skinCo.storeTag, "|") * 62 + 120, 400))
	gohelper.setActive(slot0._btnplay, not VersionValidator.instance:isInReviewing() and slot0._skinCo.isSkinVideo)
	slot0:_refreshContent()
end

function slot0._refreshContent(slot0)
	slot1 = {}
	slot3 = slot0._gocontentroot

	if string.nilorempty(slot0._skinCo.storeTag) == false then
		for slot8, slot9 in ipairs(string.splitToNumber(slot2.storeTag, "|")) do
			table.insert(slot1, SkinConfig.instance:getSkinStoreTagConfig(slot9))
		end
	end

	slot5 = #slot0._itemList

	for slot10 = 1, #slot1 do
		slot11 = slot1[slot10]
		slot12 = nil

		if slot10 <= slot5 then
			slot12 = slot4[slot10]
		else
			slot12 = CharacterSkinTagItem.New()

			slot12:init(gohelper.clone(slot0._goitem, slot3))
			table.insert(slot4, slot12)
		end

		gohelper.setActive(slot12.viewGO, true)
		slot12:onUpdateMO(slot11)
	end

	if slot6 < slot5 then
		for slot10 = slot6 + 1, slot5 do
			gohelper.setActive(slot4[slot10].viewGO, false)
		end
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goviewport.transform)

	slot8 = math.min(recthelper.getHeight(slot3.transform), slot0.MAX_TAG_HEIGHT)

	recthelper.setHeight(slot0._gocontentroot.transform, slot8)
	recthelper.setHeight(slot0._goviewport.transform, slot8)
	recthelper.setHeight(slot0._gobg.transform, slot8)
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
