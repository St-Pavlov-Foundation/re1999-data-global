module("modules.logic.characterskin.view.CharacterSkinLeftView", package.seeall)

slot0 = class("CharacterSkinLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gozs = gohelper.findChild(slot0.viewGO, "zs")
	slot0._simagebgmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgmask")
	slot0._gosmallspine = gohelper.findChild(slot0.viewGO, "smalldynamiccontainer/#go_smallspine")
	slot0._simageskin = gohelper.findChildSingleImage(slot0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	slot0._simagel2d = gohelper.findChildSingleImage(slot0.viewGO, "characterSpine/#go_skincontainer/#simage_l2d")
	slot0._gobigspine = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signature")
	slot0._simagesignatureicon = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signatureicon")
	slot0._txtcharacterName = gohelper.findChildText(slot0.viewGO, "desc/#txt_characterName")
	slot0._txtskinName = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName")
	slot0._txtskinNameEn = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "desc/#txt_desc")
	slot0._btnshowDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	slot0._btntag = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_tag")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_switch")
	slot0._btnvideo = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_video")
	slot0._txtswitch = gohelper.findChildText(slot0.viewGO, "desc/#btn_switch/#txt_switch")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowDetail:AddClickListener(slot0._btnshowDetailOnClick, slot0)
	slot0._btntag:AddClickListener(slot0._btntagOnClick, slot0)
	slot0._btnvideo:AddClickListener(slot0._btnvideoOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowDetail:RemoveClickListener()
	slot0._btntag:RemoveClickListener()
	slot0._btnvideo:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
end

function slot0.onSwitchAnimDone(slot0)
	slot0:setShaderKeyWord(false)
end

function slot0._btnswitchOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	slot0.showDynamicVertical = not slot0.showDynamicVertical

	slot0._animator:Play("switch", 0, 0)
	slot0:setShaderKeyWord(true)
	slot0:refreshTxtSwitch()
	TaskDispatcher.runDelay(slot0.refreshBigVertical, slot0, 0.16)
	TaskDispatcher.runDelay(slot0.onSwitchAnimDone, slot0, 0.6)
	CharacterController.instance:trackInteractiveSkinDetails(slot0.heroCo and slot0.heroCo.id, slot0.skinCo and slot0.skinCo.id, StatEnum.ClickType.Switch)
end

function slot0._btnvideoOnClick(slot0)
	if not slot0.skinCo then
		return
	end

	slot2 = slot0.skinCo.id

	if not HeroConfig.instance:getHeroCO(slot0.skinCo.characterId) then
		return
	end

	logNormal("播放视频,当前英雄id:" .. slot1 .. " 皮肤id: " .. slot2 .. " url: " .. WebViewController.instance:getVideoUrl(slot1, slot2))

	if UnityEngine.Application.version == "2.2.0" and GameChannelConfig.isLongCheng() and BootNativeUtil.isAndroid() then
		GameUtil.openURL(slot4)
	else
		WebViewController.instance:openWebView(slot4, false, slot0.OnWebViewBack, slot0)
	end

	CharacterController.instance:statCharacterSkinVideoData(slot1, slot3.name, slot2, slot0.skinCo.name)
end

function slot0.OnWebViewBack(slot0, slot1, slot2)
	if slot1 == WebViewEnum.WebViewCBType.Cb and slot2 == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end

	logNormal("URL Jump Callback msg" .. slot2)
end

function slot0._btntagOnClick(slot0)
	gohelper.setActive(slot0._btnvideo, false)
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = slot0.skinCo
	})
	CharacterController.instance:trackInteractiveSkinDetails(slot0.heroCo and slot0.heroCo.id, slot0.skinCo and slot0.skinCo.id, StatEnum.ClickType.Tag)
end

function slot0._btnshowDetailOnClick(slot0)
	CharacterController.instance:openCharacterSkinFullScreenView(slot0.skinCo, false, slot0.showDynamicVertical and CharacterEnum.ShowSkinEnum.Dynamic or CharacterEnum.ShowSkinEnum.Static)
	CharacterController.instance:trackInteractiveSkinDetails(slot0.heroCo and slot0.heroCo.id, slot0.skinCo and slot0.skinCo.id, StatEnum.ClickType.Detail)
end

function slot0._onOpenView(slot0, slot1)
	if slot0.showDynamicVertical and slot1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(slot0.goBigDynamicContainer, false)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:setShaderKeyWord(false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot0.showDynamicVertical and slot1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(slot0.goBigDynamicContainer, true)
	end

	if slot1 == ViewName.CharacterSkinTagView then
		slot0:_refreshVideoBtnState(false)
	end
end

function slot0._editableInitView(slot0)
	slot0.showDynamicVertical = PlayerModel.instance:getMyUserId() % 2 == 0 and true or false
	slot0.smallSpine = GuiSpine.Create(slot0._gosmallspine, false)
	slot0.goBigDynamicContainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	slot0.goBigStaticContainer = slot0._simageskin.gameObject

	slot0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	slot0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	slot0:addEventCb(CharacterController.instance, CharacterEvent.OnSwitchSkin, slot0.switchSkin, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.OnSwitchSkinVertical, slot0.switchSkinVertical, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.refreshTxtSwitch(slot0)
	slot0._txtswitch.text = slot0.showDynamicVertical and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function slot0.switchSkinVertical(slot0, slot1, slot2)
	if slot0.viewName == slot2 then
		slot0.showDynamicVertical = slot1
	end
end

function slot0.switchSkin(slot0, slot1, slot2)
	if slot0.viewName == slot2 then
		slot0.skinCo = slot1
		slot0.heroCo = HeroConfig.instance:getHeroCO(slot0.skinCo.characterId)

		slot0:refreshSkin()
	end
end

function slot0.refreshSignature(slot0)
	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0.heroCo.signature, "characterget"))

	if slot0.skinCo.signature == "3011" then
		slot0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
		gohelper.setActive(slot0._simagesignatureicon.gameObject, true)
	else
		gohelper.setActive(slot0._simagesignatureicon.gameObject, false)
	end
end

function slot0.refreshSkin(slot0)
	slot0:resetRes()
	slot0:refreshSignature()
	slot0:refreshBigVertical()
	slot0:refreshSmallVertical()
	slot0:_refreshSkinInfo()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSkinSwitchSpine, slot0.skinCo.id)
end

function slot0.resetRes(slot0)
	if slot0.bigSpine then
		slot0.bigSpine:onDestroy()
	end

	slot0._simageskin:UnLoadImage()
	slot0._simagel2d:UnLoadImage()
end

function slot0.refreshBigVertical(slot0)
	gohelper.setActive(slot0.goBigDynamicContainer, slot0.showDynamicVertical)
	gohelper.setActive(slot0._simageskin.gameObject, not slot0.showDynamicVertical)

	if slot0.showDynamicVertical then
		if slot0.bigSpine == nil then
			slot0.bigSpine = GuiModelAgent.Create(slot0._gobigspine, true)
		end

		slot0.bigSpine:setResPath(slot0.skinCo, slot0.onBigSpineLoaded, slot0)
	else
		slot0._simageskin:LoadImage(ResUrl.getHeadIconImg(slot0.skinCo.id), slot0._loadedImage, slot0)
	end

	if not string.nilorempty(slot0.skinCo.live2dbg) then
		gohelper.setActive(slot0._simagel2d.gameObject, slot0.showDynamicVertical)
		gohelper.setActive(slot0._gozs, slot0.showDynamicVertical)
		slot0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(slot1))
	else
		gohelper.setActive(slot0._simagel2d.gameObject, false)
		gohelper.setActive(slot0._gozs, false)
	end
end

function slot0._refreshSkinInfo(slot0)
	gohelper.setActive(slot0._btnswitch, slot0.skinCo.showSwitchBtn == 1)

	slot0._txtcharacterName.text = HeroConfig.instance:getHeroCO(slot0.skinCo.characterId).name
	slot0._txtdesc.text = slot0.skinCo.skinDescription

	slot0:_refreshVideoBtnState(true)

	if string.nilorempty(slot0.skinCo.characterSkin) then
		gohelper.setActive(slot0._txtskinName.gameObject, false)

		slot0._txtskinNameEn.text = ""
	else
		gohelper.setActive(slot0._txtskinName.gameObject, true)

		slot0._txtskinName.text = slot0.skinCo.characterSkin
		slot0._txtskinNameEn.text = slot0.skinCo.characterSkinNameEng
	end

	gohelper.setActive(slot0._btntag.gameObject, not string.nilorempty(slot0.skinCo.storeTag))
	slot0:refreshTxtSwitch()
end

function slot0._refreshVideoBtnState(slot0, slot1)
	slot3 = not VersionValidator.instance:isInReviewing() and slot0.skinCo.isSkinVideo

	gohelper.setActive(slot0._btnvideo, slot3)

	if slot3 and slot1 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onVideoBtnDisplay, slot0.viewContainer.viewName)
	end
end

function slot0.onBigSpineLoaded(slot0)
	slot0.bigSpine:setAllLayer(UnityLayer.SceneEffect)

	if string.nilorempty(slot0.skinCo.skinViewLive2dOffset) then
		slot1 = slot0.skinCo.characterViewOffset
	end

	slot2 = SkinConfig.instance:getSkinOffset(slot1)

	recthelper.setAnchor(slot0._gobigspine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
	transformhelper.setLocalScale(slot0._gobigspine.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
end

function slot0._loadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageskin.gameObject)

	if not string.nilorempty(slot0.skinCo.skinViewImgOffset) then
		slot2 = string.splitToNumber(slot1, "#")

		recthelper.setAnchor(slot0._simageskin.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._simageskin.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	else
		recthelper.setAnchor(slot0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(slot0._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function slot0.refreshSmallVertical(slot0)
	slot0.smallSpine:stopVoice()
	slot0.smallSpine:setResPath(ResUrl.getSpineUIPrefab(slot0.skinCo.spine), slot0.onSmallSpineLoaded, slot0, true)
end

function slot0.onSmallSpineLoaded(slot0)
	slot1 = SkinConfig.instance:getSkinOffset(slot0.skinCo.skinSpineOffset)

	recthelper.setAnchor(slot0._gosmallspine.transform, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0._gosmallspine.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
end

function slot0.onClose(slot0)
	slot0._simageskin:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
	slot0._simagesignatureicon:UnLoadImage()
	slot0._simagel2d:UnLoadImage()

	if slot0.bigSpine then
		slot0.bigSpine:setModelVisible(false)
	end
end

function slot0.setShaderKeyWord(slot0, slot1)
	if slot1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.onSwitchAnimDone, slot0)
	TaskDispatcher.cancelTask(slot0.refreshBigVertical, slot0)

	if slot0.smallSpine then
		slot0.smallSpine:stopVoice()

		slot0.smallSpine = nil
	end

	if slot0.bigSpine then
		slot0.bigSpine:onDestroy()

		slot0.bigSpine = nil
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagebgmask:UnLoadImage()
end

return slot0
