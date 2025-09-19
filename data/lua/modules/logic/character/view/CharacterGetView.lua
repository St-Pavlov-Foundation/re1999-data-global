module("modules.logic.character.view.CharacterGetView", package.seeall)

local var_0_0 = class("CharacterGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_bg")
	arg_1_0._simageredcirclebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_redcirclebg")
	arg_1_0._simagecircle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_circle/circlewainew/circle")
	arg_1_0._simagetxtbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_txtbg")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/#image_careericon")
	arg_1_0._imagecareerline = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/#image_careericon/#image_careerline")
	arg_1_0._simagecareericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#image_careericon_big")
	arg_1_0._simagebgleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/leftbg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "charactercontainer/#go_spine")
	arg_1_0._simageblackbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "introduce/#simage_blackbg")
	arg_1_0._simagesignatureicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "introduce/#simage_signatureicon")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "introduce/#simage_signature")
	arg_1_0._txtcharacterNameCn = gohelper.findChildText(arg_1_0.viewGO, "introduce/#txt_characterNameCn")
	arg_1_0._gostarList = gohelper.findChild(arg_1_0.viewGO, "introduce/#go_starList")
	arg_1_0._gobottomTalk = gohelper.findChild(arg_1_0.viewGO, "#go_bottomTalk")
	arg_1_0._txttalkcn = gohelper.findChildText(arg_1_0.viewGO, "#go_bottomTalk/#txt_talkcn")
	arg_1_0._txttalken = gohelper.findChildText(arg_1_0.viewGO, "#go_bottomTalk/#txt_talken")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._gobgmask = gohelper.findChild(arg_1_0.viewGO, "#go_bgmask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	if arg_4_0.isPlayLimitedVideo then
		arg_4_0:_limitedVideoFinished()

		return
	end

	if arg_4_0._isSummonTen then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
		arg_4_0:closeThis()
	elseif not arg_4_0._animFinish then
		arg_4_0:_skipAnim()
	end
end

function var_0_0._skipAnim(arg_5_0, arg_5_1)
	if arg_5_0._isSummon and not arg_5_0._isSummonTen then
		gohelper.setActive(arg_5_0._btnskip.gameObject, false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	arg_5_0._animSkip = true

	if arg_5_1 then
		arg_5_0:_openAnimFinish()
	else
		arg_5_0._animatorPlayer:Play("skip", arg_5_0._openAnimFinish, arg_5_0)
	end

	arg_5_0:setFullScreenMaskVisible(false)
	arg_5_0:stopDelayVideoOverTime()
	arg_5_0:_resetVideo()
end

function var_0_0._onBgClick(arg_6_0)
	if arg_6_0.isPlayLimitedVideo then
		gohelper.setActive(arg_6_0._btnskip.gameObject, true)
	end

	if arg_6_0._animFinish then
		local var_6_0 = false

		if arg_6_0._isRank then
			if arg_6_0._startRank and arg_6_0._startRank < arg_6_0._newRank then
				for iter_6_0 = arg_6_0._startRank + 1, arg_6_0._newRank do
					if SkillConfig.instance:isGetNewSkin(arg_6_0._heroId, iter_6_0) then
						var_6_0 = true
					end
				end
			else
				var_6_0 = SkillConfig.instance:isGetNewSkin(arg_6_0._heroId, arg_6_0._newRank)
			end
		end

		if arg_6_0._isRank and var_6_0 then
			arg_6_0:hideCurrentView()
			CharacterController.instance:dispatchEvent(CharacterEvent.showCharacterNewSkin)
		else
			arg_6_0:closeThis()
		end
	elseif not arg_6_0._animSkip and arg_6_0._isSummon and arg_6_0._duplicateCount > 0 then
		arg_6_0:_skipAnim(true)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._animSkip = true
	arg_7_0._gobg = gohelper.findChild(arg_7_0.viewGO, "bg")
	arg_7_0._gocontainer = gohelper.findChild(arg_7_0.viewGO, "charactercontainer")
	arg_7_0._bgClick = gohelper.getClickWithAudio(arg_7_0._gobg)

	arg_7_0._bgClick:AddClickListener(arg_7_0._onBgClick, arg_7_0)
	arg_7_0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/bg_characterget"))
	arg_7_0._simageredcirclebg:LoadImage(ResUrl.getCharacterGetIcon("bg_yuan"))
	arg_7_0._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
	arg_7_0._simageblackbg:LoadImage(ResUrl.getCharacterGetIcon("heisedi"))
	arg_7_0._simagebgleft:LoadImage(ResUrl.getCharacterGetIcon("bg_wz"))

	arg_7_0._uiSpine = GuiModelAgent.Create(arg_7_0._gospine, true)

	arg_7_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_7_0.viewName)

	arg_7_0._starList = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, 6 do
		local var_7_0 = gohelper.findChild(arg_7_0._gostarList, "star" .. iter_7_0)

		table.insert(arg_7_0._starList, var_7_0)
	end

	arg_7_0._txttalkcn.text = ""
	arg_7_0._txttalken.text = ""
	arg_7_0._rankList = arg_7_0:getUserDataTb_()
	arg_7_0._goeffectstarList = gohelper.findChild(arg_7_0.viewGO, "#go_bg/xingxing")
	arg_7_0._effectstarList = arg_7_0:getUserDataTb_()

	for iter_7_1 = 1, 6 do
		local var_7_1 = gohelper.findChild(arg_7_0._goeffectstarList, "star" .. iter_7_1)

		table.insert(arg_7_0._effectstarList, var_7_1)
	end

	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO)
	arg_7_0._animEventWrap = arg_7_0._animator:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_7_0._animEventWrap:AddEventListener("star", arg_7_0._playStarAudio, arg_7_0)
	arg_7_0._animEventWrap:AddEventListener("skip", arg_7_0._playSkip, arg_7_0)

	arg_7_0._videoGo = gohelper.findChild(arg_7_0.viewGO, "#go_bg/videoplayer")

	arg_7_0:setFullScreenMaskVisible(true)
end

function var_0_0._initVideoPlayer(arg_8_0)
	if not arg_8_0._videoPlayer then
		arg_8_0._videoPlayer, arg_8_0._displauUGUI, arg_8_0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(arg_8_0._videoGo)

		local var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._videoPlayerGO, FullScreenVideoAdapter)

		arg_8_0._videoPlayerGO = nil
	end
end

function var_0_0.setFullScreenMaskVisible(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._gobgmask, arg_9_1)
end

function var_0_0._videoStatusUpdate(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == AvProEnum.PlayerStatus.Started then
		arg_10_0._animSkip = false

		arg_10_0:setFullScreenMaskVisible(false)
		arg_10_0._animatorPlayer:Play(UIAnimationName.Open, arg_10_0._openAnimFinish, arg_10_0)

		arg_10_0._animator.speed = 1

		arg_10_0._animator:Play(UIAnimationName.Idle, 1, 0)

		if arg_10_0._rare < 3 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Low_Hero)
		elseif arg_10_0._rare < 5 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Middle_Hero)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_High_Hero)
		end
	elseif arg_10_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		if arg_10_0._isSummon and not arg_10_0._isSummonTen then
			gohelper.setActive(arg_10_0._btnskip.gameObject, false)
		end

		arg_10_0:setFullScreenMaskVisible(false)
		arg_10_0:stopDelayVideoOverTime()
		arg_10_0:_resetVideo()
	end
end

function var_0_0._resetVideo(arg_11_0)
	gohelper.setActive(arg_11_0._videoGo, false)

	if not arg_11_0._videoPlayer then
		return
	end

	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		arg_11_0._videoPlayer:Stop()
	else
		arg_11_0._videoPlayer:Stop()
	end
end

function var_0_0._playSkip(arg_12_0)
	arg_12_0._animSkip = true

	logNormal("skip rare = " .. tostring(arg_12_0._rare))

	if arg_12_0._rare < 3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_General_Last)
	elseif arg_12_0._rare < 5 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Medium_Last)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Special_Last)
	end
end

function var_0_0._playStarAudio(arg_13_0)
	if arg_13_0._playedStar >= arg_13_0._star then
		return
	end

	arg_13_0._playedStar = arg_13_0._playedStar + 1

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)
end

function var_0_0._playOpenAnimation(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._openAnimFinish, arg_14_0)

	arg_14_0._animator.enabled = true

	arg_14_0._animator:Play(UIAnimationName.Open, 0, 0)
	arg_14_0._animator:Play(UIAnimationName.Idle, 1, 0)

	arg_14_0._animator.speed = 0

	arg_14_0._animator:Update(0)
	arg_14_0._animatorPlayer:Play(UIAnimationName.Open, arg_14_0._openAnimFinish, arg_14_0)
	gohelper.setActive(arg_14_0._videoGo, true)
	arg_14_0:_initVideoPlayer()
	arg_14_0._videoPlayer:Play(arg_14_0._displauUGUI, langVideoUrl("character_get_start"), false, arg_14_0._videoStatusUpdate, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0.handleVideoOverTime, arg_14_0, 10)
end

function var_0_0._openAnimFinish(arg_15_0)
	arg_15_0._animSkip = true

	TaskDispatcher.cancelTask(arg_15_0._openAnimFinish, arg_15_0)

	if gohelper.isNil(arg_15_0._animator) then
		return
	end

	arg_15_0._animator.enabled = true

	arg_15_0._animator:Play(UIAnimationName.Loop, 0, 0)
	arg_15_0._animator:Play(UIAnimationName.Voice, 1, 0)

	arg_15_0._animFinish = true

	arg_15_0:_tryPlayVoice()

	local var_15_0 = HeroConfig.instance:getHeroCO(arg_15_0._heroId)

	if not var_15_0 then
		logError("找不到角色: " .. tostring(arg_15_0._heroId))

		return
	end

	if arg_15_0._isReplay then
		return
	end

	if arg_15_0._isRank then
		GameFacade.showToast(ToastEnum.CharacterGet, var_15_0.name)
	else
		CharacterController.instance:showCharacterGetToast(arg_15_0._heroId, arg_15_0._duplicateCount)
		CharacterController.instance:showCharacterGetTicket(arg_15_0._heroId, arg_15_0._summonTicketId)
	end
end

function var_0_0.handleVideoOverTime(arg_16_0)
	arg_16_0:stopDelayVideoOverTime()
	arg_16_0:setFullScreenMaskVisible(false)
	arg_16_0:_resetVideo()
	gohelper.setActive(arg_16_0._videoGo, false)
	arg_16_0:_openAnimFinish()
end

function var_0_0.stopDelayVideoOverTime(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.handleVideoOverTime, arg_17_0)
end

function var_0_0._loadSpine(arg_18_0)
	local var_18_0

	if arg_18_0._isRank then
		var_18_0 = HeroModel.instance:getCurrentSkinConfig(arg_18_0._heroId)
	else
		local var_18_1 = HeroConfig.instance:getHeroCO(arg_18_0._heroId)

		var_18_0 = var_18_1 and SkinConfig.instance:getSkinCo(var_18_1.skinId)
	end

	if var_18_0 then
		arg_18_0._skinConfig = var_18_0

		arg_18_0._uiSpine:setResPath(var_18_0, arg_18_0._onSpineLoaded, arg_18_0)

		local var_18_2, var_18_3 = SkinConfig.instance:getSkinOffset(var_18_0.characterGetViewOffset)

		if var_18_3 then
			var_18_2, _ = SkinConfig.instance:getSkinOffset(var_18_0.characterViewOffset)
			var_18_2 = SkinConfig.instance:getAfterRelativeOffset(505, var_18_2)
		end

		recthelper.setAnchor(arg_18_0._gospine.transform, tonumber(var_18_2[1]), tonumber(var_18_2[2]))
		transformhelper.setLocalScale(arg_18_0._gospine.transform, tonumber(var_18_2[3]), tonumber(var_18_2[3]), tonumber(var_18_2[3]))
	else
		logError("找不到角色皮肤: " .. tostring(arg_18_0._heroId))
	end
end

function var_0_0._refreshShow(arg_19_0)
	local var_19_0 = HeroConfig.instance:getHeroCO(arg_19_0._heroId)

	if not var_19_0 then
		logError("找不到角色: " .. tostring(arg_19_0._heroId))

		return
	end

	if arg_19_0._uiSpine then
		arg_19_0._uiSpine:stopVoice()
	end

	gohelper.setActive(arg_19_0._gobottomTalk, false)
	gohelper.setActive(arg_19_0._btnskip.gameObject, arg_19_0._isSummon and not SummonController.instance:isInSummonGuide())
	arg_19_0:_loadSpine()

	arg_19_0._txtcharacterNameCn.text = var_19_0.name

	arg_19_0._simagecareericon:LoadImage(ResUrl.getCharacterGetIcon("charactercareer_big_0" .. var_19_0.career))
	UISpriteSetMgr.instance:setCharactergetSprite(arg_19_0._imagecareericon, "charactercareer" .. var_19_0.career)
	UISpriteSetMgr.instance:setCharactergetSprite(arg_19_0._imagecareerline, "line_" .. var_19_0.career)
	arg_19_0._simagesignature:LoadImage(ResUrl.getSignature(var_19_0.signature, "characterget"), arg_19_0._setSignatureImageSize, arg_19_0)
	arg_19_0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"), arg_19_0._setSignatureImageSize, arg_19_0)

	arg_19_0._playedStar = 0
	arg_19_0._star = CharacterEnum.Star[var_19_0.rare]

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._starList) do
		gohelper.setActive(iter_19_1, iter_19_0 <= CharacterEnum.Star[var_19_0.rare])
	end

	for iter_19_2, iter_19_3 in ipairs(arg_19_0._effectstarList) do
		gohelper.setActive(iter_19_3, iter_19_2 <= CharacterEnum.Star[var_19_0.rare])
	end

	arg_19_0._simagetxtbg:LoadImage(ResUrl.getCharacterGetIcon("herorare_" .. var_19_0.rare))

	arg_19_0._rare = var_19_0.rare

	gohelper.setActive(arg_19_0._simagesignatureicon.gameObject, var_19_0.signature == "3011")
end

function var_0_0._setSignatureImageSize(arg_20_0)
	ZProj.UGUIHelper.SetImageSize(arg_20_0._simagesignature.gameObject)
end

function var_0_0._onSpineLoaded(arg_21_0)
	arg_21_0._spineLoaded = true

	arg_21_0:_tryPlayVoice()
end

function var_0_0._tryPlayVoice(arg_22_0)
	if not arg_22_0._animFinish or not arg_22_0._spineLoaded then
		return
	end

	local var_22_0
	local var_22_1

	if arg_22_0._isRank then
		if SkillConfig.instance:isGetNewSkin(arg_22_0._heroId, arg_22_0._newRank) then
			var_22_1 = CharacterEnum.VoiceType.GetSkin
		else
			var_22_1 = CharacterEnum.VoiceType.BreakThrough
		end
	else
		var_22_1 = CharacterEnum.VoiceType.Summon
	end

	local var_22_2 = HeroModel.instance:getVoiceConfig(arg_22_0._heroId, var_22_1, nil, arg_22_0._skinConfig and arg_22_0._skinConfig.id)

	if not var_22_2 or #var_22_2 <= 0 then
		logNormal("没有对应的角色语音类型:" .. tostring(var_22_1))

		return
	end

	local var_22_3 = var_22_2[math.random(#var_22_2)]

	arg_22_0._uiSpine:playVoice(var_22_3, nil, arg_22_0._txttalkcn, arg_22_0._txttalken, arg_22_0._gobottomTalk)
end

function var_0_0.onOpen(arg_23_0)
	gohelper.setActive(arg_23_0._gocontainer, true)

	arg_23_0._heroId = arg_23_0.viewParam.heroId
	arg_23_0._duplicateCount = arg_23_0.viewParam.duplicateCount or 0
	arg_23_0._callback = arg_23_0.viewParam.callback
	arg_23_0._callbackObj = arg_23_0.viewParam.callbackObj
	arg_23_0._isRank = arg_23_0.viewParam.isRank
	arg_23_0._newRank = arg_23_0.viewParam.newRank
	arg_23_0._startRank = arg_23_0.viewParam.startRank
	arg_23_0._isReplay = arg_23_0.viewParam.isReplay
	arg_23_0._isSummon = arg_23_0.viewParam.isSummon
	arg_23_0._isSummonTen = arg_23_0.viewParam.isSummonTen
	arg_23_0._skipVideo = arg_23_0.viewParam.skipVideo
	arg_23_0._summonTicketId = arg_23_0.viewParam.summonTicketId
	arg_23_0._mvSkinId = arg_23_0.viewParam.mvSkinId

	if arg_23_0.viewParam.openFromGuide then
		arg_23_0._heroId = tonumber(arg_23_0.viewParam.viewParam)

		HeroModel.instance:addGuideHero(arg_23_0._heroId)
	end

	arg_23_0._animFinish = false
	arg_23_0._spineLoaded = false
	arg_23_0.isPlayLimitedVideo = false
	arg_23_0._goSkinDetailContainer = gohelper.findChild(arg_23_0.viewGO, "characterskingetdetailview")

	gohelper.setActive(arg_23_0._goSkinDetailContainer, false)
	arg_23_0:_refreshShow()
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, arg_23_0._onBgClick, arg_23_0)

	if arg_23_0._skipVideo then
		if arg_23_0._mvSkinId then
			arg_23_0:_playLimitedVideo(arg_23_0._mvSkinId)
		else
			arg_23_0:_skipAnim()
		end
	else
		arg_23_0:_playOpenAnimation()
	end
end

function var_0_0.onUpdateParam(arg_24_0)
	arg_24_0._heroId = arg_24_0.viewParam.heroId
	arg_24_0._duplicateCount = arg_24_0.viewParam.duplicateCount or 0
	arg_24_0._callback = arg_24_0.viewParam.callback
	arg_24_0._callbackObj = arg_24_0.viewParam.callbackObj
	arg_24_0._isRank = arg_24_0.viewParam.isRank
	arg_24_0._newRank = arg_24_0.viewParam.newRank
	arg_24_0._isReplay = arg_24_0.viewParam.isReplay
	arg_24_0._isSummon = arg_24_0.viewParam.isSummon
	arg_24_0._isSummonTen = arg_24_0.viewParam.isSummonTen
	arg_24_0._skipVideo = arg_24_0.viewParam.skipVideo
	arg_24_0._spineLoaded = false
	arg_24_0._animFinish = false
	arg_24_0._mvSkinId = arg_24_0.viewParam.mvSkinId
	arg_24_0.isPlayLimitedVideo = false
	arg_24_0._goSkinDetailContainer = gohelper.findChild(arg_24_0.viewGO, "characterskingetdetailview")

	gohelper.setActive(arg_24_0._goSkinDetailContainer, false)
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, arg_24_0._onBgClick, arg_24_0)
	arg_24_0:_refreshShow()

	if arg_24_0._skipVideo then
		if arg_24_0._mvSkinId then
			arg_24_0:_playLimitedVideo(arg_24_0._mvSkinId)
		else
			arg_24_0:_skipAnim()
		end
	else
		arg_24_0:_playOpenAnimation()
	end
end

function var_0_0.hideCurrentView(arg_25_0)
	arg_25_0._animator:Play("characterget_skin")
end

function var_0_0.onClose(arg_26_0)
	if arg_26_0._isRank and arg_26_0.viewContainer:isManualClose() then
		CharacterController.instance:openCharacterRankUpResultView(arg_26_0._heroId)
	end

	TaskDispatcher.cancelTask(arg_26_0._openAnimFinish, arg_26_0)

	if arg_26_0.viewParam.openFromGuide then
		HeroModel.instance:removeGuideHero(arg_26_0._heroId)
	end

	if arg_26_0._uiSpine then
		arg_26_0._uiSpine:stopVoice()
	end

	gohelper.setActive(arg_26_0._gocontainer, false)

	if arg_26_0._callback then
		arg_26_0._callback(arg_26_0._callbackObj)
	end

	arg_26_0:stopDelayVideoOverTime()
end

function var_0_0._playLimitedVideo(arg_27_0, arg_27_1)
	arg_27_0._animator.enabled = true
	arg_27_0._animator.speed = 0

	arg_27_0._animator:Update(0)
	arg_27_0._animator:Play(UIAnimationName.Open, 0, 0)
	arg_27_0:setFullScreenMaskVisible(false)
	gohelper.setActive(arg_27_0._videoGo, true)
	gohelper.setActive(arg_27_0._btnskip.gameObject, false)
	arg_27_0:_initVideoPlayer()

	arg_27_0._limitedCO = lua_character_limited.configDict[arg_27_1]

	arg_27_0._videoPlayer:Play(arg_27_0._displauUGUI, langVideoUrl(arg_27_0._limitedCO.entranceMv), false, arg_27_0._limitedVideoStatusUpdate, arg_27_0)

	arg_27_0.isPlayLimitedVideo = true

	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Summon)
	TaskDispatcher.runRepeat(arg_27_0._stopMainBgm, arg_27_0, 0.2, 100)
	TaskDispatcher.runDelay(arg_27_0.handleVideoOverTime, arg_27_0, arg_27_0._limitedCO.mvtime)
end

function var_0_0._stopMainBgm(arg_28_0)
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Summon)
end

function var_0_0._limitedVideoStatusUpdate(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2 == AvProEnum.PlayerStatus.Started and arg_29_0._limitedCO and arg_29_0._limitedCO.audio > 0 then
		AudioMgr.instance:trigger(arg_29_0._limitedCO.audio)
	end

	if arg_29_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_29_0:_limitedVideoFinished()
	end
end

function var_0_0._limitedVideoFinished(arg_30_0)
	if arg_30_0._isSummon and not arg_30_0._isSummonTen then
		gohelper.setActive(arg_30_0._btnskip.gameObject, false)
	end

	if arg_30_0._limitedCO and arg_30_0._limitedCO.audio > 0 then
		AudioMgr.instance:trigger(arg_30_0._limitedCO.stopAudio)
	end

	arg_30_0.isPlayLimitedVideo = false
	arg_30_0._animator.speed = 1

	arg_30_0._animatorPlayer:Play("skip", arg_30_0._openAnimFinish, arg_30_0)
	arg_30_0:setFullScreenMaskVisible(false)
	arg_30_0:stopDelayVideoOverTime()
	arg_30_0:_resetVideo()
	TaskDispatcher.cancelTask(arg_30_0.handleVideoOverTime, arg_30_0)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Summon)
end

function var_0_0.onDestroyView(arg_31_0)
	arg_31_0._bgClick:RemoveClickListener()
	arg_31_0._simagebg:UnLoadImage()
	arg_31_0._simageredcirclebg:UnLoadImage()
	arg_31_0._simagecircle:UnLoadImage()
	arg_31_0._simagetxtbg:UnLoadImage()
	arg_31_0._simageblackbg:UnLoadImage()
	arg_31_0._simagebgleft:UnLoadImage()
	arg_31_0._simagecareericon:UnLoadImage()
	arg_31_0._simagesignature:UnLoadImage()
	arg_31_0._simagesignatureicon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_31_0._loadSpine, arg_31_0)

	if arg_31_0._uiSpine then
		arg_31_0._uiSpine:onDestroy()

		arg_31_0._uiSpine = nil
	end

	gohelper.setActive(arg_31_0._gocontainer, true)
	gohelper.destroy(arg_31_0._gocontainer)
	arg_31_0._animEventWrap:RemoveAllEventListener()

	if arg_31_0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			arg_31_0._videoPlayer:Stop()
		end

		arg_31_0._videoPlayer:Clear()

		arg_31_0._videoPlayer = nil
	end
end

return var_0_0
