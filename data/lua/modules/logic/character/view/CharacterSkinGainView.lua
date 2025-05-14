module("modules.logic.character.view.CharacterSkinGainView", package.seeall)

local var_0_0 = class("CharacterSkinGainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bgroot/#simage_bg")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bgroot/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bgroot/#simage_righticon")
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "root/bgroot/#go_skincontainer")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bgroot/#go_skincontainer/#simage_icon")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bgroot/#simage_mask")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "root/bgroot/#image_careericon")
	arg_1_0._imagecareerline = gohelper.findChildImage(arg_1_0.viewGO, "root/bgroot/#image_careericon/#image_careerline")
	arg_1_0._txtlinecn = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#txt_line_cn")
	arg_1_0._txtlineen = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#txt_line_cn/#txt_line_en")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/#simage_bg/#simage_signature")
	arg_1_0._txtskinname = gohelper.findChildText(arg_1_0.viewGO, "root/left/#simage_bg/#txt_skinname")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/left/#simage_bg/#txt_skinname/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "root/left/#simage_bg/#txt_skinname/#txt_name/#txt_name_en")
	arg_1_0._btndress = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_clothing")
	arg_1_0._goclothed = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_clothed")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "root/bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#txt_ana_en")
	arg_1_0._golive2dcontainer = gohelper.findChild(arg_1_0.viewGO, "root/bgroot/#go_live2dcontainer/live2dcontainer/#go_live2d")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndress:AddClickListener(arg_2_0._btndressOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndress:RemoveClickListener()
end

function var_0_0._btndressOnClick(arg_4_0)
	if not arg_4_0._switchFinish then
		return
	end

	HeroRpc.instance:sendUseSkinRequest(arg_4_0._skinCo.characterId, arg_4_0._skinCo.id)
end

function var_0_0._onBgClick(arg_5_0)
	if arg_5_0._switchFinish then
		arg_5_0:closeThis()
	elseif arg_5_0._animFinish then
		arg_5_0:_playSwitchAnimation()
	end
end

function var_0_0._editableInitView(arg_6_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")

	arg_6_0._bgClick = gohelper.getClickWithAudio(arg_6_0.viewGO)

	arg_6_0._bgClick:AddClickListener(arg_6_0._onBgClick, arg_6_0)
	arg_6_0._simagebg:LoadImage("singlebg/characterskin/full/bg_huode.png")
	arg_6_0._simagelefticon:LoadImage("singlebg/characterskin/bg_huode_leftup.png")
	arg_6_0._simagerighticon:LoadImage("singlebg/characterskin/bg_huode_rightdown.png")
	arg_6_0._simagemask:LoadImage("singlebg/characterskin/full/bg_huode_mask.png")

	arg_6_0._simagecareericon = gohelper.findChildSingleImage(arg_6_0.viewGO, "root/bgroot/#image_careericon_big")
	arg_6_0.goRight = gohelper.findChild(arg_6_0.viewGO, "root/right")
	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "root/bgroot/videoplayer")

	arg_6_0._videoPlayer, arg_6_0._displauUGUI = AvProMgr.instance:getVideoPlayer(var_6_0)

	arg_6_0._videoPlayer:AddDisplayUGUI(arg_6_0._displauUGUI)
	arg_6_0._videoPlayer:SetEventListener(arg_6_0._videoStatusUpdate, arg_6_0)
	arg_6_0._videoPlayer:LoadMedia(langVideoUrl("character_get_start"))

	arg_6_0._gostarList = gohelper.findChild(arg_6_0.viewGO, "root/effect/xingxing")
	arg_6_0._starList = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 6 do
		local var_6_1 = gohelper.findChild(arg_6_0._gostarList, "star" .. iter_6_0)

		table.insert(arg_6_0._starList, var_6_1)
	end

	gohelper.setActive(arg_6_0._gocontentbg, false)

	arg_6_0._txtanacn.text = ""
	arg_6_0._txtanaen.text = ""

	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_6_0._successDressUpSkin, arg_6_0)
end

function var_0_0._videoStatusUpdate(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == AvProEnum.PlayerStatus.Started then
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_skin_get)
	elseif arg_7_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_7_0:_resetVideo()
	end
end

function var_0_0._resetVideo(arg_8_0)
	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		arg_8_0._videoPlayer:Stop()
	else
		arg_8_0._videoPlayer:Stop()
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	if arg_10_0.playHeroVoice then
		arg_10_0.playHeroVoice:dispose()
	end

	if arg_10_0._uiSpine then
		arg_10_0._uiSpine:stopVoice()
	end

	arg_10_0._animFinish = false
	arg_10_0._switchFinish = false

	NavigateMgr.instance:addEscape(arg_10_0.viewName, arg_10_0._onBgClick, arg_10_0)
	arg_10_0:_refreshView()
	arg_10_0:_playOpenAnimation()
end

function var_0_0._refreshView(arg_11_0)
	arg_11_0._skinCo = SkinConfig.instance:getSkinCo(arg_11_0.viewParam.skinId)
	arg_11_0._heroMo = HeroModel.instance:getByHeroId(arg_11_0._skinCo.characterId)

	local var_11_0 = HeroConfig.instance:getHeroCO(arg_11_0._skinCo.characterId)

	arg_11_0:_setNameBgWidth(arg_11_0._skinCo.characterSkin, var_11_0 and var_11_0.name or "")

	arg_11_0._txtskinname.text = arg_11_0._skinCo.characterSkin

	if var_11_0 then
		gohelper.setActive(arg_11_0._txtname.gameObject, true)

		arg_11_0._txtname.text = var_11_0.name
	else
		gohelper.setActive(arg_11_0._txtname.gameObject, false)
	end

	arg_11_0._txtnameen.text = arg_11_0._skinCo.nameEng
	arg_11_0._uiSpine = GuiModelAgent.Create(arg_11_0._golive2dcontainer, true)

	arg_11_0._uiSpine:setResPath(arg_11_0._skinCo, arg_11_0._onUISpineLoaded, arg_11_0)
	arg_11_0._simageicon:LoadImage(ResUrl.getHeadIconImg(arg_11_0._skinCo.id), arg_11_0._loadedImage, arg_11_0)
	arg_11_0._simagesignature:LoadImage(ResUrl.getSignature(var_11_0.signature))
	UISpriteSetMgr.instance:setCharactergetSprite(arg_11_0._imagecareericon, "charactercareer" .. var_11_0.career)
	UISpriteSetMgr.instance:setCharactergetSprite(arg_11_0._imagecareerline, "line_" .. var_11_0.career)
	arg_11_0._simagecareericon:LoadImage(ResUrl.getCharacterGetIcon("charactercareer_big_0" .. var_11_0.career))

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._starList) do
		gohelper.setActive(iter_11_1, iter_11_0 <= CharacterEnum.Star[var_11_0.rare])
	end

	arg_11_0:refreshDressStatus()
end

function var_0_0._onUISpineLoaded(arg_12_0)
	local var_12_0 = arg_12_0._skinCo.skinGainViewLive2dOffset

	if string.nilorempty(var_12_0) then
		var_12_0 = arg_12_0._skinCo.characterViewOffset
	end

	local var_12_1 = SkinConfig.instance:getSkinOffset(var_12_0)

	recthelper.setAnchor(arg_12_0._golive2dcontainer.transform, tonumber(var_12_1[1]), tonumber(var_12_1[2]))
	transformhelper.setLocalScale(arg_12_0._golive2dcontainer.transform, tonumber(var_12_1[3]), tonumber(var_12_1[3]), tonumber(var_12_1[3]))
end

function var_0_0._loadedImage(arg_13_0)
	ZProj.UGUIHelper.SetImageSize(arg_13_0._simageicon.gameObject)

	local var_13_0 = arg_13_0._skinCo.skinGainViewImgOffset

	if not string.nilorempty(var_13_0) then
		local var_13_1 = string.splitToNumber(var_13_0, "#")

		recthelper.setAnchor(arg_13_0._goskincontainer.transform, tonumber(var_13_1[1]), tonumber(var_13_1[2]))
		transformhelper.setLocalScale(arg_13_0._goskincontainer.transform, tonumber(var_13_1[3]), tonumber(var_13_1[3]), tonumber(var_13_1[3]))
	else
		recthelper.setAnchor(arg_13_0._goskincontainer.transform, 0, 0)
		transformhelper.setLocalScale(arg_13_0._goskincontainer.transform, 1, 1, 1)
	end
end

function var_0_0._onSingleItemLoaded(arg_14_0)
	local var_14_0 = SkinConfig.instance:getSkinOffset(arg_14_0._skinCo.skinGetDetailViewIconOffset)

	recthelper.setAnchor(arg_14_0._simagesingleItemIcon.transform, tonumber(var_14_0[1]), tonumber(var_14_0[2]))
	transformhelper.setLocalScale(arg_14_0._simagesingleItemIcon.transform, tonumber(var_14_0[3]), tonumber(var_14_0[3]), tonumber(var_14_0[3]))
end

function var_0_0._playOpenAnimation(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._openAnimFinish, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._openAnimFinish, arg_15_0, 10)

	arg_15_0._animFinish = false

	arg_15_0._animatorPlayer:Play(UIAnimationName.Open, arg_15_0._openAnimFinish, arg_15_0)
	arg_15_0._videoPlayer:Play(arg_15_0._displauUGUI, false)
end

function var_0_0._playSwitchAnimation(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._switchAnimFinish, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._switchAnimFinish, arg_16_0, 10)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_get_1)

	arg_16_0._switchFinish = false
	arg_16_0._animFinish = false

	arg_16_0._animatorPlayer:Play(UIAnimationName.Switch, arg_16_0._switchAnimFinish, arg_16_0)
end

function var_0_0._openAnimFinish(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._openAnimFinish, arg_17_0)

	arg_17_0._animFinish = true
end

function var_0_0._switchAnimFinish(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._switchAnimFinish, arg_18_0)
	arg_18_0:_playVoice()

	arg_18_0._switchFinish = true

	arg_18_0:refreshDressStatus()
end

function var_0_0._successDressUpSkin(arg_19_0)
	GameFacade.showToast(ToastEnum.CharacterSkinGain, HeroConfig.instance:getHeroCO(arg_19_0._skinCo.characterId).name)
	arg_19_0:refreshDressStatus()
end

function var_0_0._playVoice(arg_20_0)
	local var_20_0

	if arg_20_0._skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank then
		var_20_0 = CharacterEnum.VoiceType.GetSkin
	else
		var_20_0 = CharacterEnum.VoiceType.Summon
	end

	if not var_20_0 then
		return
	end

	local var_20_1 = HeroModel.instance:getVoiceConfig(arg_20_0._skinCo.characterId, var_20_0, nil, arg_20_0._skinCo.id)

	if not var_20_1 or #var_20_1 <= 0 then
		GameFacade.showToast(ToastEnum.DontHaveCharacter)

		local var_20_2 = CharacterDataConfig.instance:getCharacterVoicesCo(arg_20_0._skinCo.characterId)

		var_20_1 = {}

		if var_20_2 then
			for iter_20_0, iter_20_1 in pairs(var_20_2) do
				if iter_20_1.type == var_20_0 and HeroModel.instance:_checkSkin(nil, iter_20_1, arg_20_0._skinCo.id) then
					table.insert(var_20_1, iter_20_1)
				end
			end
		end
	end

	if not var_20_1 or #var_20_1 <= 0 then
		logNormal("没有对应的角色语音类型:" .. tostring(var_20_0))

		return
	end

	local var_20_3 = var_20_1[math.random(#var_20_1)]

	arg_20_0._uiSpine:playVoice(var_20_3, nil, arg_20_0._txtanacn, arg_20_0._txtanaen, arg_20_0._gocontentbg)
end

function var_0_0._setNameBgWidth(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._nameBgRoot = gohelper.findChild(arg_21_0.viewGO, "root/left/#simage_bg")
	arg_21_0._nameBg = gohelper.findChild(arg_21_0._nameBgRoot, "bg")

	local var_21_0 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_21_0._txtskinname, arg_21_1)
	local var_21_1 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_21_0._txtname, arg_21_2)
	local var_21_2 = recthelper.getAnchorX(arg_21_0._txtname.transform) or 0
	local var_21_3 = var_21_0 + (var_21_1 - math.abs(var_21_2)) + 450

	recthelper.setWidth(arg_21_0._nameBg.transform, var_21_3)
end

function var_0_0.refreshDressStatus(arg_22_0)
	gohelper.setActive(arg_22_0.goRight, arg_22_0._heroMo)

	if not arg_22_0._switchFinish then
		gohelper.setActive(arg_22_0._btndress.gameObject, false)
		gohelper.setActive(arg_22_0._goclothed, false)

		return
	end

	if arg_22_0._heroMo then
		gohelper.setActive(arg_22_0._btndress.gameObject, arg_22_0._skinCo.id ~= arg_22_0._heroMo.skin)
		gohelper.setActive(arg_22_0._goclothed, arg_22_0._skinCo.id == arg_22_0._heroMo.skin)
	end
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._switchAnimFinish, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._openAnimFinish, arg_23_0)
	arg_23_0._simagesignature:UnLoadImage()
end

function var_0_0.onDestroyView(arg_24_0)
	if arg_24_0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			arg_24_0._videoPlayer:Stop()
		end

		arg_24_0._videoPlayer:Clear()

		arg_24_0._videoPlayer = nil
	end

	if arg_24_0._uiSpine then
		arg_24_0._uiSpine:stopVoice()
		arg_24_0._uiSpine:onDestroy()

		arg_24_0._uiSpine = nil
	end

	if arg_24_0.playHeroVoice then
		arg_24_0.playHeroVoice:dispose()
	end

	if arg_24_0._bgClick then
		arg_24_0._bgClick:RemoveClickListener()
	end

	NavigateMgr.instance:removeEscape(arg_24_0.viewName, arg_24_0._onBgClick, arg_24_0)
	arg_24_0._simagebg:UnLoadImage()
	arg_24_0._simagemask:UnLoadImage()
	arg_24_0._simagelefticon:UnLoadImage()
	arg_24_0._simagerighticon:UnLoadImage()
end

return var_0_0
