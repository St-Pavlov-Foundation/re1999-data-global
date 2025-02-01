module("modules.logic.character.view.CharacterGetView", package.seeall)

slot0 = class("CharacterGetView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_bg")
	slot0._simageredcirclebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_redcirclebg")
	slot0._simagecircle = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_circle/circlewainew/circle")
	slot0._simagetxtbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_txtbg")
	slot0._imagecareericon = gohelper.findChildImage(slot0.viewGO, "#go_bg/#image_careericon")
	slot0._imagecareerline = gohelper.findChildImage(slot0.viewGO, "#go_bg/#image_careericon/#image_careerline")
	slot0._simagecareericon = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#image_careericon_big")
	slot0._simagebgleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/leftbg")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "charactercontainer/#go_spine")
	slot0._simageblackbg = gohelper.findChildSingleImage(slot0.viewGO, "introduce/#simage_blackbg")
	slot0._simagesignatureicon = gohelper.findChildSingleImage(slot0.viewGO, "introduce/#simage_signatureicon")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "introduce/#simage_signature")
	slot0._txtcharacterNameCn = gohelper.findChildText(slot0.viewGO, "introduce/#txt_characterNameCn")
	slot0._gostarList = gohelper.findChild(slot0.viewGO, "introduce/#go_starList")
	slot0._gobottomTalk = gohelper.findChild(slot0.viewGO, "#go_bottomTalk")
	slot0._txttalkcn = gohelper.findChildText(slot0.viewGO, "#go_bottomTalk/#txt_talkcn")
	slot0._txttalken = gohelper.findChildText(slot0.viewGO, "#go_bottomTalk/#txt_talken")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._gobgmask = gohelper.findChild(slot0.viewGO, "#go_bgmask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	if slot0.isPlayLimitedVideo then
		slot0:_limitedVideoFinished()

		return
	end

	if slot0._isSummonTen then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
		slot0:closeThis()
	elseif not slot0._animFinish then
		slot0:_skipAnim()
	end
end

function slot0._skipAnim(slot0, slot1)
	if slot0._isSummon and not slot0._isSummonTen then
		gohelper.setActive(slot0._btnskip.gameObject, false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	slot0._animSkip = true

	if slot1 then
		slot0:_openAnimFinish()
	else
		slot0._animatorPlayer:Play("skip", slot0._openAnimFinish, slot0)
	end

	slot0:setFullScreenMaskVisible(false)
	slot0:stopDelayVideoOverTime()
	slot0:_resetVideo()
end

function slot0._onBgClick(slot0)
	if slot0.isPlayLimitedVideo then
		gohelper.setActive(slot0._btnskip.gameObject, true)
	end

	if slot0._animFinish then
		slot1 = false

		if slot0._isRank then
			if slot0._startRank and slot0._startRank < slot0._newRank then
				for slot5 = slot0._startRank + 1, slot0._newRank do
					if SkillConfig.instance:isGetNewSkin(slot0._heroId, slot5) then
						slot1 = true
					end
				end
			else
				slot1 = SkillConfig.instance:isGetNewSkin(slot0._heroId, slot0._newRank)
			end
		end

		if slot0._isRank and slot1 then
			slot0:hideCurrentView()
			CharacterController.instance:dispatchEvent(CharacterEvent.showCharacterNewSkin)
		else
			slot0:closeThis()
		end
	elseif not slot0._animSkip and slot0._isSummon and slot0._duplicateCount > 0 then
		slot0:_skipAnim(true)
	end
end

function slot0._editableInitView(slot0)
	slot0._animSkip = true
	slot0._gobg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "charactercontainer")
	slot0._bgClick = gohelper.getClickWithAudio(slot0._gobg)

	slot0._bgClick:AddClickListener(slot0._onBgClick, slot0)
	slot0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/bg_characterget"))
	slot0._simageredcirclebg:LoadImage(ResUrl.getCharacterGetIcon("bg_yuan"))
	slot0._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
	slot0._simageblackbg:LoadImage(ResUrl.getCharacterGetIcon("heisedi"))

	slot4 = "bg_wz"

	slot0._simagebgleft:LoadImage(ResUrl.getCharacterGetIcon(slot4))

	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)
	slot0._starList = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		table.insert(slot0._starList, gohelper.findChild(slot0._gostarList, "star" .. slot4))
	end

	slot0._txttalkcn.text = ""
	slot0._txttalken.text = ""
	slot0._rankList = slot0:getUserDataTb_()
	slot0._goeffectstarList = gohelper.findChild(slot0.viewGO, "#go_bg/xingxing")
	slot0._effectstarList = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		table.insert(slot0._effectstarList, gohelper.findChild(slot0._goeffectstarList, "star" .. slot4))
	end

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._animEventWrap = slot0._animator:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("star", slot0._playStarAudio, slot0)
	slot0._animEventWrap:AddEventListener("skip", slot0._playSkip, slot0)

	slot0._videoGo = gohelper.findChild(slot0.viewGO, "#go_bg/videoplayer")

	slot0:setFullScreenMaskVisible(true)
end

function slot0._initVideoPlayer(slot0)
	if not slot0._videoPlayer then
		slot0._videoPlayer, slot0._displauUGUI, slot0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(slot0._videoGo)
		slot1 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._videoPlayerGO, FullScreenVideoAdapter)
		slot0._videoPlayerGO = nil
	end
end

function slot0.setFullScreenMaskVisible(slot0, slot1)
	gohelper.setActive(slot0._gobgmask, slot1)
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.Started then
		slot0._animSkip = false

		slot0:setFullScreenMaskVisible(false)
		slot0._animatorPlayer:Play(UIAnimationName.Open, slot0._openAnimFinish, slot0)

		slot0._animator.speed = 1

		slot0._animator:Play(UIAnimationName.Idle, 1, 0)

		if slot0._rare < 3 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Low_Hero)
		elseif slot0._rare < 5 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Middle_Hero)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_High_Hero)
		end
	elseif slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		if slot0._isSummon and not slot0._isSummonTen then
			gohelper.setActive(slot0._btnskip.gameObject, false)
		end

		slot0:setFullScreenMaskVisible(false)
		slot0:stopDelayVideoOverTime()
		slot0:_resetVideo()
	end
end

function slot0._resetVideo(slot0)
	gohelper.setActive(slot0._videoGo, false)

	if not slot0._videoPlayer then
		return
	end

	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		slot0._videoPlayer:Stop()
	else
		slot0._videoPlayer:Stop()
	end
end

function slot0._playSkip(slot0)
	slot0._animSkip = true

	logNormal("skip rare = " .. tostring(slot0._rare))

	if slot0._rare < 3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_General_Last)
	elseif slot0._rare < 5 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Medium_Last)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Special_Last)
	end
end

function slot0._playStarAudio(slot0)
	if slot0._star <= slot0._playedStar then
		return
	end

	slot0._playedStar = slot0._playedStar + 1

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)
end

function slot0._playOpenAnimation(slot0)
	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)

	slot0._animator.enabled = true

	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	slot0._animator:Play(UIAnimationName.Idle, 1, 0)

	slot0._animator.speed = 0

	slot0._animator:Update(0)
	slot0._animatorPlayer:Play(UIAnimationName.Open, slot0._openAnimFinish, slot0)
	gohelper.setActive(slot0._videoGo, true)
	slot0:_initVideoPlayer()
	slot0._videoPlayer:Play(slot0._displauUGUI, langVideoUrl("character_get_start"), false, slot0._videoStatusUpdate, slot0)
	TaskDispatcher.runDelay(slot0.handleVideoOverTime, slot0, 10)
end

function slot0._openAnimFinish(slot0)
	slot0._animSkip = true

	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)

	if gohelper.isNil(slot0._animator) then
		return
	end

	slot0._animator.enabled = true

	slot0._animator:Play(UIAnimationName.Loop, 0, 0)
	slot0._animator:Play(UIAnimationName.Voice, 1, 0)

	slot0._animFinish = true

	slot0:_tryPlayVoice()

	if not HeroConfig.instance:getHeroCO(slot0._heroId) then
		logError("找不到角色: " .. tostring(slot0._heroId))

		return
	end

	if slot0._isReplay then
		return
	end

	if slot0._isRank then
		GameFacade.showToast(ToastEnum.CharacterGet, slot1.name)
	else
		CharacterController.instance:showCharacterGetToast(slot0._heroId, slot0._duplicateCount)
		CharacterController.instance:showCharacterGetTicket(slot0._heroId, slot0._summonTicketId)
	end
end

function slot0.handleVideoOverTime(slot0)
	slot0:stopDelayVideoOverTime()
	slot0:setFullScreenMaskVisible(false)
	slot0:_resetVideo()
	gohelper.setActive(slot0._videoGo, false)
	slot0:_openAnimFinish()
end

function slot0.stopDelayVideoOverTime(slot0)
	TaskDispatcher.cancelTask(slot0.handleVideoOverTime, slot0)
end

function slot0._loadSpine(slot0)
	slot1 = nil

	if (not slot0._isRank or HeroModel.instance:getCurrentSkinConfig(slot0._heroId)) and HeroConfig.instance:getHeroCO(slot0._heroId) and SkinConfig.instance:getSkinCo(slot2.skinId) then
		slot0._skinConfig = slot1

		slot0._uiSpine:setResPath(slot1, slot0._onSpineLoaded, slot0)

		slot2, slot3 = SkinConfig.instance:getSkinOffset(slot1.characterGetViewOffset)

		if slot3 then
			slot4, _ = SkinConfig.instance:getSkinOffset(slot1.characterViewOffset)
			slot2 = SkinConfig.instance:getAfterRelativeOffset(505, slot4)
		end

		recthelper.setAnchor(slot0._gospine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._gospine.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	else
		logError("找不到角色皮肤: " .. tostring(slot0._heroId))
	end
end

function slot0._refreshShow(slot0)
	if not HeroConfig.instance:getHeroCO(slot0._heroId) then
		logError("找不到角色: " .. tostring(slot0._heroId))

		return
	end

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	gohelper.setActive(slot0._gobottomTalk, false)
	gohelper.setActive(slot0._btnskip.gameObject, slot0._isSummon and not SummonController.instance:isInSummonGuide())
	slot0:_loadSpine()

	slot0._txtcharacterNameCn.text = slot1.name

	slot0._simagecareericon:LoadImage(ResUrl.getCharacterGetIcon("charactercareer_big_0" .. slot1.career))
	UISpriteSetMgr.instance:setCharactergetSprite(slot0._imagecareericon, "charactercareer" .. slot1.career)
	UISpriteSetMgr.instance:setCharactergetSprite(slot0._imagecareerline, "line_" .. slot1.career)
	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot1.signature, "characterget"), slot0._setSignatureImageSize, slot0)
	slot0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"), slot0._setSignatureImageSize, slot0)

	slot0._playedStar = 0
	slot0._star = CharacterEnum.Star[slot1.rare]

	for slot5, slot6 in ipairs(slot0._starList) do
		gohelper.setActive(slot6, slot5 <= CharacterEnum.Star[slot1.rare])
	end

	for slot5, slot6 in ipairs(slot0._effectstarList) do
		gohelper.setActive(slot6, slot5 <= CharacterEnum.Star[slot1.rare])
	end

	slot0._simagetxtbg:LoadImage(ResUrl.getCharacterGetIcon("herorare_" .. slot1.rare))

	slot0._rare = slot1.rare

	gohelper.setActive(slot0._simagesignatureicon.gameObject, slot1.signature == "3011")
end

function slot0._setSignatureImageSize(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simagesignature.gameObject)
end

function slot0._onSpineLoaded(slot0)
	slot0._spineLoaded = true

	slot0:_tryPlayVoice()
end

function slot0._tryPlayVoice(slot0)
	if not slot0._animFinish or not slot0._spineLoaded then
		return
	end

	slot1, slot2 = nil

	if not HeroModel.instance:getVoiceConfig(slot0._heroId, (not slot0._isRank or (not SkillConfig.instance:isGetNewSkin(slot0._heroId, slot0._newRank) or CharacterEnum.VoiceType.GetSkin) and CharacterEnum.VoiceType.BreakThrough) and CharacterEnum.VoiceType.Summon, nil, slot0._skinConfig and slot0._skinConfig.id) or #slot1 <= 0 then
		logNormal("没有对应的角色语音类型:" .. tostring(slot2))

		return
	end

	slot0._uiSpine:playVoice(slot1[math.random(#slot1)], nil, slot0._txttalkcn, slot0._txttalken, slot0._gobottomTalk)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gocontainer, true)

	slot0._heroId = slot0.viewParam.heroId
	slot0._duplicateCount = slot0.viewParam.duplicateCount or 0
	slot0._callback = slot0.viewParam.callback
	slot0._callbackObj = slot0.viewParam.callbackObj
	slot0._isRank = slot0.viewParam.isRank
	slot0._newRank = slot0.viewParam.newRank
	slot0._startRank = slot0.viewParam.startRank
	slot0._isReplay = slot0.viewParam.isReplay
	slot0._isSummon = slot0.viewParam.isSummon
	slot0._isSummonTen = slot0.viewParam.isSummonTen
	slot0._skipVideo = slot0.viewParam.skipVideo
	slot0._summonTicketId = slot0.viewParam.summonTicketId
	slot0._mvSkinId = slot0.viewParam.mvSkinId

	if slot0.viewParam.openFromGuide then
		slot0._heroId = tonumber(slot0.viewParam.viewParam)

		HeroModel.instance:addGuideHero(slot0._heroId)
	end

	slot0._animFinish = false
	slot0._spineLoaded = false
	slot0.isPlayLimitedVideo = false
	slot0._goSkinDetailContainer = gohelper.findChild(slot0.viewGO, "characterskingetdetailview")

	gohelper.setActive(slot0._goSkinDetailContainer, false)
	slot0:_refreshShow()
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, slot0._onBgClick, slot0)

	if slot0._skipVideo then
		if slot0._mvSkinId then
			slot0:_playLimitedVideo(slot0._mvSkinId)
		else
			slot0:_skipAnim()
		end
	else
		slot0:_playOpenAnimation()
	end
end

function slot0.onUpdateParam(slot0)
	slot0._heroId = slot0.viewParam.heroId
	slot0._duplicateCount = slot0.viewParam.duplicateCount or 0
	slot0._callback = slot0.viewParam.callback
	slot0._callbackObj = slot0.viewParam.callbackObj
	slot0._isRank = slot0.viewParam.isRank
	slot0._newRank = slot0.viewParam.newRank
	slot0._isReplay = slot0.viewParam.isReplay
	slot0._isSummon = slot0.viewParam.isSummon
	slot0._isSummonTen = slot0.viewParam.isSummonTen
	slot0._skipVideo = slot0.viewParam.skipVideo
	slot0._spineLoaded = false
	slot0._animFinish = false
	slot0._mvSkinId = slot0.viewParam.mvSkinId
	slot0.isPlayLimitedVideo = false
	slot0._goSkinDetailContainer = gohelper.findChild(slot0.viewGO, "characterskingetdetailview")

	gohelper.setActive(slot0._goSkinDetailContainer, false)
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, slot0._onBgClick, slot0)
	slot0:_refreshShow()

	if slot0._skipVideo then
		if slot0._mvSkinId then
			slot0:_playLimitedVideo(slot0._mvSkinId)
		else
			slot0:_skipAnim()
		end
	else
		slot0:_playOpenAnimation()
	end
end

function slot0.hideCurrentView(slot0)
	slot0._animator:Play("characterget_skin")
end

function slot0.onClose(slot0)
	if slot0._isRank and slot0.viewContainer:isManualClose() then
		CharacterController.instance:openCharacterRankUpResultView(slot0._heroId)
	end

	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)

	if slot0.viewParam.openFromGuide then
		HeroModel.instance:removeGuideHero(slot0._heroId)
	end

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	gohelper.setActive(slot0._gocontainer, false)

	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end

	slot0:stopDelayVideoOverTime()
end

function slot0._playLimitedVideo(slot0, slot1)
	slot0._animator.enabled = true
	slot0._animator.speed = 0

	slot0._animator:Update(0)
	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	slot0:setFullScreenMaskVisible(false)
	gohelper.setActive(slot0._videoGo, true)
	gohelper.setActive(slot0._btnskip.gameObject, false)
	slot0:_initVideoPlayer()

	slot0._limitedCO = lua_character_limited.configDict[slot1]

	slot0._videoPlayer:Play(slot0._displauUGUI, langVideoUrl(slot0._limitedCO.entranceMv), false, slot0._limitedVideoStatusUpdate, slot0)

	slot0.isPlayLimitedVideo = true

	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Summon)
	TaskDispatcher.runRepeat(slot0._stopMainBgm, slot0, 0.2, 100)
	TaskDispatcher.runDelay(slot0.handleVideoOverTime, slot0, slot0._limitedCO.mvtime)
end

function slot0._stopMainBgm(slot0)
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Summon)
end

function slot0._limitedVideoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.Started and slot0._limitedCO and slot0._limitedCO.audio > 0 then
		AudioMgr.instance:trigger(slot0._limitedCO.audio)
	end

	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:_limitedVideoFinished()
	end
end

function slot0._limitedVideoFinished(slot0)
	if slot0._isSummon and not slot0._isSummonTen then
		gohelper.setActive(slot0._btnskip.gameObject, false)
	end

	if slot0._limitedCO and slot0._limitedCO.audio > 0 then
		AudioMgr.instance:trigger(slot0._limitedCO.stopAudio)
	end

	slot0.isPlayLimitedVideo = false
	slot0._animator.speed = 1

	slot0._animatorPlayer:Play("skip", slot0._openAnimFinish, slot0)
	slot0:setFullScreenMaskVisible(false)
	slot0:stopDelayVideoOverTime()
	slot0:_resetVideo()
	TaskDispatcher.cancelTask(slot0.handleVideoOverTime, slot0)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Summon)
end

function slot0.onDestroyView(slot0)
	slot0._bgClick:RemoveClickListener()
	slot0._simagebg:UnLoadImage()
	slot0._simageredcirclebg:UnLoadImage()
	slot0._simagecircle:UnLoadImage()
	slot0._simagetxtbg:UnLoadImage()
	slot0._simageblackbg:UnLoadImage()
	slot0._simagebgleft:UnLoadImage()
	slot0._simagecareericon:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
	slot0._simagesignatureicon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._loadSpine, slot0)

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	gohelper.setActive(slot0._gocontainer, true)
	gohelper.destroy(slot0._gocontainer)
	slot0._animEventWrap:RemoveAllEventListener()

	if slot0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			slot0._videoPlayer:Stop()
		end

		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

return slot0
