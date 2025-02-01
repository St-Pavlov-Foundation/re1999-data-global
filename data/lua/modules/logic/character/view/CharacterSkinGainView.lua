module("modules.logic.character.view.CharacterSkinGainView", package.seeall)

slot0 = class("CharacterSkinGainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "root/bgroot/#simage_bg")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "root/bgroot/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "root/bgroot/#simage_righticon")
	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "root/bgroot/#go_skincontainer")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "root/bgroot/#go_skincontainer/#simage_icon")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "root/bgroot/#simage_mask")
	slot0._imagecareericon = gohelper.findChildImage(slot0.viewGO, "root/bgroot/#image_careericon")
	slot0._imagecareerline = gohelper.findChildImage(slot0.viewGO, "root/bgroot/#image_careericon/#image_careerline")
	slot0._txtlinecn = gohelper.findChildText(slot0.viewGO, "root/bottom/#txt_line_cn")
	slot0._txtlineen = gohelper.findChildText(slot0.viewGO, "root/bottom/#txt_line_cn/#txt_line_en")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "root/left/#simage_bg/#simage_signature")
	slot0._txtskinname = gohelper.findChildText(slot0.viewGO, "root/left/#simage_bg/#txt_skinname")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "root/left/#simage_bg/#txt_skinname/#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "root/left/#simage_bg/#txt_skinname/#txt_name/#txt_name_en")
	slot0._btndress = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#btn_clothing")
	slot0._goclothed = gohelper.findChild(slot0.viewGO, "root/right/#go_clothed")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "root/bottom/#go_contentbg")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "root/bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "root/bottom/#txt_ana_en")
	slot0._golive2dcontainer = gohelper.findChild(slot0.viewGO, "root/bgroot/#go_live2dcontainer/live2dcontainer/#go_live2d")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndress:AddClickListener(slot0._btndressOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndress:RemoveClickListener()
end

function slot0._btndressOnClick(slot0)
	if not slot0._switchFinish then
		return
	end

	HeroRpc.instance:sendUseSkinRequest(slot0._skinCo.characterId, slot0._skinCo.id)
end

function slot0._onBgClick(slot0)
	if slot0._switchFinish then
		slot0:closeThis()
	elseif slot0._animFinish then
		slot0:_playSwitchAnimation()
	end
end

function slot0._editableInitView(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")

	slot0._bgClick = gohelper.getClickWithAudio(slot0.viewGO)

	slot0._bgClick:AddClickListener(slot0._onBgClick, slot0)
	slot0._simagebg:LoadImage("singlebg/characterskin/full/bg_huode.png")
	slot0._simagelefticon:LoadImage("singlebg/characterskin/bg_huode_leftup.png")
	slot0._simagerighticon:LoadImage("singlebg/characterskin/bg_huode_rightdown.png")
	slot0._simagemask:LoadImage("singlebg/characterskin/full/bg_huode_mask.png")

	slot0._simagecareericon = gohelper.findChildSingleImage(slot0.viewGO, "root/bgroot/#image_careericon_big")
	slot0.goRight = gohelper.findChild(slot0.viewGO, "root/right")
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._videoPlayer, slot0._displauUGUI = AvProMgr.instance:getVideoPlayer(gohelper.findChild(slot0.viewGO, "root/bgroot/videoplayer"))

	slot0._videoPlayer:AddDisplayUGUI(slot0._displauUGUI)
	slot0._videoPlayer:SetEventListener(slot0._videoStatusUpdate, slot0)

	slot5 = "character_get_start"

	slot0._videoPlayer:LoadMedia(langVideoUrl(slot5))

	slot0._gostarList = gohelper.findChild(slot0.viewGO, "root/effect/xingxing")
	slot0._starList = slot0:getUserDataTb_()

	for slot5 = 1, 6 do
		table.insert(slot0._starList, gohelper.findChild(slot0._gostarList, "star" .. slot5))
	end

	gohelper.setActive(slot0._gocontentbg, false)

	slot0._txtanacn.text = ""
	slot0._txtanaen.text = ""

	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._successDressUpSkin, slot0)
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.Started then
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_skin_get)
	elseif slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:_resetVideo()
	end
end

function slot0._resetVideo(slot0)
	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		slot0._videoPlayer:Stop()
	else
		slot0._videoPlayer:Stop()
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.playHeroVoice then
		slot0.playHeroVoice:dispose()
	end

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	slot0._animFinish = false
	slot0._switchFinish = false

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onBgClick, slot0)
	slot0:_refreshView()
	slot0:_playOpenAnimation()
end

function slot0._refreshView(slot0)
	slot0._skinCo = SkinConfig.instance:getSkinCo(slot0.viewParam.skinId)
	slot0._heroMo = HeroModel.instance:getByHeroId(slot0._skinCo.characterId)

	slot0:_setNameBgWidth(slot0._skinCo.characterSkin, HeroConfig.instance:getHeroCO(slot0._skinCo.characterId) and slot1.name or "")

	slot0._txtskinname.text = slot0._skinCo.characterSkin

	if slot1 then
		gohelper.setActive(slot0._txtname.gameObject, true)

		slot0._txtname.text = slot1.name
	else
		gohelper.setActive(slot0._txtname.gameObject, false)
	end

	slot0._txtnameen.text = slot0._skinCo.nameEng
	slot0._uiSpine = GuiModelAgent.Create(slot0._golive2dcontainer, true)

	slot0._uiSpine:setResPath(slot0._skinCo, slot0._onUISpineLoaded, slot0)
	slot0._simageicon:LoadImage(ResUrl.getHeadIconImg(slot0._skinCo.id), slot0._loadedImage, slot0)
	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot1.signature))
	UISpriteSetMgr.instance:setCharactergetSprite(slot0._imagecareericon, "charactercareer" .. slot1.career)
	UISpriteSetMgr.instance:setCharactergetSprite(slot0._imagecareerline, "line_" .. slot1.career)

	slot6 = slot1.career
	slot5 = "charactercareer_big_0" .. slot6

	slot0._simagecareericon:LoadImage(ResUrl.getCharacterGetIcon(slot5))

	for slot5, slot6 in ipairs(slot0._starList) do
		gohelper.setActive(slot6, slot5 <= CharacterEnum.Star[slot1.rare])
	end

	slot0:refreshDressStatus()
end

function slot0._onUISpineLoaded(slot0)
	if string.nilorempty(slot0._skinCo.skinGainViewLive2dOffset) then
		slot1 = slot0._skinCo.characterViewOffset
	end

	slot2 = SkinConfig.instance:getSkinOffset(slot1)

	recthelper.setAnchor(slot0._golive2dcontainer.transform, tonumber(slot2[1]), tonumber(slot2[2]))
	transformhelper.setLocalScale(slot0._golive2dcontainer.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
end

function slot0._loadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageicon.gameObject)

	if not string.nilorempty(slot0._skinCo.skinGainViewImgOffset) then
		slot2 = string.splitToNumber(slot1, "#")

		recthelper.setAnchor(slot0._goskincontainer.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._goskincontainer.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	else
		recthelper.setAnchor(slot0._goskincontainer.transform, 0, 0)
		transformhelper.setLocalScale(slot0._goskincontainer.transform, 1, 1, 1)
	end
end

function slot0._onSingleItemLoaded(slot0)
	slot1 = SkinConfig.instance:getSkinOffset(slot0._skinCo.skinGetDetailViewIconOffset)

	recthelper.setAnchor(slot0._simagesingleItemIcon.transform, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0._simagesingleItemIcon.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
end

function slot0._playOpenAnimation(slot0)
	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)
	TaskDispatcher.runDelay(slot0._openAnimFinish, slot0, 10)

	slot0._animFinish = false

	slot0._animatorPlayer:Play(UIAnimationName.Open, slot0._openAnimFinish, slot0)
	slot0._videoPlayer:Play(slot0._displauUGUI, false)
end

function slot0._playSwitchAnimation(slot0)
	TaskDispatcher.cancelTask(slot0._switchAnimFinish, slot0)
	TaskDispatcher.runDelay(slot0._switchAnimFinish, slot0, 10)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_get_1)

	slot0._switchFinish = false
	slot0._animFinish = false

	slot0._animatorPlayer:Play(UIAnimationName.Switch, slot0._switchAnimFinish, slot0)
end

function slot0._openAnimFinish(slot0)
	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)

	slot0._animFinish = true
end

function slot0._switchAnimFinish(slot0)
	TaskDispatcher.cancelTask(slot0._switchAnimFinish, slot0)
	slot0:_playVoice()

	slot0._switchFinish = true

	slot0:refreshDressStatus()
end

function slot0._successDressUpSkin(slot0)
	GameFacade.showToast(ToastEnum.CharacterSkinGain, HeroConfig.instance:getHeroCO(slot0._skinCo.characterId).name)
	slot0:refreshDressStatus()
end

function slot0._playVoice(slot0)
	slot1 = nil

	if not ((slot0._skinCo.gainApproach ~= CharacterEnum.SkinGainApproach.Rank or CharacterEnum.VoiceType.GetSkin) and CharacterEnum.VoiceType.Summon) then
		return
	end

	if not HeroModel.instance:getVoiceConfig(slot0._skinCo.characterId, slot1, nil, slot0._skinCo.id) or #slot2 <= 0 then
		GameFacade.showToast(ToastEnum.DontHaveCharacter)

		slot2 = {}

		if CharacterDataConfig.instance:getCharacterVoicesCo(slot0._skinCo.characterId) then
			for slot7, slot8 in pairs(slot3) do
				if slot8.type == slot1 and HeroModel.instance:_checkSkin(nil, slot8, slot0._skinCo.id) then
					table.insert(slot2, slot8)
				end
			end
		end
	end

	if not slot2 or #slot2 <= 0 then
		logNormal("没有对应的角色语音类型:" .. tostring(slot1))

		return
	end

	slot0._uiSpine:playVoice(slot2[math.random(#slot2)], nil, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
end

function slot0._setNameBgWidth(slot0, slot1, slot2)
	slot0._nameBgRoot = gohelper.findChild(slot0.viewGO, "root/left/#simage_bg")
	slot0._nameBg = gohelper.findChild(slot0._nameBgRoot, "bg")

	recthelper.setWidth(slot0._nameBg.transform, SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txtskinname, slot1) + SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txtname, slot2) - math.abs(recthelper.getAnchorX(slot0._txtname.transform) or 0) + 450)
end

function slot0.refreshDressStatus(slot0)
	gohelper.setActive(slot0.goRight, slot0._heroMo)

	if not slot0._switchFinish then
		gohelper.setActive(slot0._btndress.gameObject, false)
		gohelper.setActive(slot0._goclothed, false)

		return
	end

	if slot0._heroMo then
		gohelper.setActive(slot0._btndress.gameObject, slot0._skinCo.id ~= slot0._heroMo.skin)
		gohelper.setActive(slot0._goclothed, slot0._skinCo.id == slot0._heroMo.skin)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._switchAnimFinish, slot0)
	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)
	slot0._simagesignature:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	if slot0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			slot0._videoPlayer:Stop()
		end

		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	if slot0.playHeroVoice then
		slot0.playHeroVoice:dispose()
	end

	if slot0._bgClick then
		slot0._bgClick:RemoveClickListener()
	end

	NavigateMgr.instance:removeEscape(slot0.viewName, slot0._onBgClick, slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
end

return slot0
