module("modules.logic.character.view.CharacterDataVoiceView", package.seeall)

local var_0_0 = class("CharacterDataVoiceView", BaseView)
local var_0_1 = "RefreshVoiceListBlock"

function var_0_0._onSpineLoaded_overseas(arg_1_0)
	if not arg_1_0._uiSpine:isLive2D() then
		return
	end

	local var_1_0 = arg_1_0._uiSpine._curModel

	if not var_1_0 then
		return
	end

	arg_1_0._charactercontainerTrans = gohelper.findChild(arg_1_0.viewGO, "content/#simage_characterbg/charactercontainer").transform

	local var_1_1 = arg_1_0._charactercontainerTrans.localPosition.x

	FrameTimerController.onDestroyViewMember(arg_1_0, "_frameTimer")

	arg_1_0._frameTimer = FrameTimerController.instance:register(function(arg_2_0)
		arg_2_0:_doProcessEffect()

		local var_2_0 = arg_2_0._uiEffectGos

		if not var_2_0 then
			return
		end

		local var_2_1 = arg_1_0._charactercontainerTrans.localPosition.x

		if math.abs(var_2_1 - var_1_1) <= 0.1 then
			return
		end

		var_1_1 = var_2_1

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			transformhelper.setLocalPosXY(iter_2_1.transform, 0, 0)
			arg_2_0:_adjustPos(iter_2_1, iter_2_1)

			local var_2_2 = arg_2_0._uiEffectConfig.scale

			transformhelper.setLocalScale(iter_2_1.transform, var_2_2, var_2_2, var_2_2)
		end
	end, var_1_0, 8, 5)

	arg_1_0._frameTimer:Start()
end

function var_0_0._unloadBnk(arg_3_0)
	if not arg_3_0._curAudio or arg_3_0._curAudio == 0 then
		return
	end

	local var_3_0 = AudioConfig.instance:getAudioCOById(arg_3_0._curAudio)

	if not var_3_0 then
		return
	end

	if not arg_3_0._willChangeLangId then
		return
	end

	local var_3_1 = var_3_0.bankName
	local var_3_2 = AudioMgr.instance:getLangByAudioId(arg_3_0._curAudio)

	if LangSettings.shortCut2LangIdxTab[var_3_2] ~= arg_3_0._willChangeLangId then
		ZProj.AudioManager.Instance:UnloadBank(var_3_1)
		AudioMgr.instance:clearUnusedBanks()
	end
end

function var_0_0.onInitView(arg_4_0)
	arg_4_0._simagebg = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/#simage_bg")
	arg_4_0._simagecentericon = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/#simage_centericon")
	arg_4_0._simagelefticon = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/#simage_lefticon")
	arg_4_0._simagerighticon = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/#simage_righticon")
	arg_4_0._simagerighticon2 = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/#simage_righticon2")
	arg_4_0._simagemask = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/#simage_mask")
	arg_4_0._simagevoicebg = gohelper.findChildSingleImage(arg_4_0.viewGO, "content/#simage_voicebg")
	arg_4_0._txtvoicecontent = gohelper.findChildText(arg_4_0.viewGO, "content/#txt_voicecontent")
	arg_4_0._txtvoiceengcontent = gohelper.findChildText(arg_4_0.viewGO, "content/#txt_voicecontent/#txt_voiceengcontent")
	arg_4_0._txtcast = gohelper.findChildText(arg_4_0.viewGO, "content/cast/#txt_cast")
	arg_4_0._gospine = gohelper.findChild(arg_4_0.viewGO, "content/#simage_characterbg/charactercontainer/#go_spine")
	arg_4_0._dropfilter = gohelper.findChildDropdown(arg_4_0.viewGO, "dropvoicelang")
	arg_4_0._goDropEffect = gohelper.findChild(arg_4_0.viewGO, "dropvoicelang/eff")
	arg_4_0._goarrowdown = gohelper.findChild(arg_4_0.viewGO, "dropvoicelang/arrow")
	arg_4_0._goarrowup = gohelper.findChild(arg_4_0.viewGO, "dropvoicelang/arrowUp")

	if arg_4_0._editableInitView then
		arg_4_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_5_0)
	arg_5_0._dropfilter:AddOnValueChanged(arg_5_0._onDropFilterValueChanged, arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	arg_6_0._dropfilter:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._scroll = gohelper.findChild(arg_7_0.viewGO, "content/#scroll_vioce"):GetComponent(typeof(ZProj.LimitedScrollRect))

	arg_7_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_7_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_2_ciecle.png"))
	arg_7_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_7_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_7_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_7_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_7_0._simagevoicebg:LoadImage(ResUrl.getCharacterDataIcon("bg_yuyingdizidi_035.png"))

	arg_7_0._curAudio = 0
	arg_7_0._uiSpine = GuiModelAgent.Create(arg_7_0._gospine, true)

	arg_7_0._uiSpine:openBloomView(CharacterVoiceEnum.UIBloomView.CharacterDataView)
	arg_7_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.BloomAuto)
	CharacterController.instance:registerCallback(CharacterEvent.PlayVoice, arg_7_0._onPlayVoice, arg_7_0)
	CharacterController.instance:registerCallback(CharacterEvent.StopVoice, arg_7_0._onStopVoice, arg_7_0)

	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._onPlayVoice(arg_8_0, arg_8_1)
	arg_8_0._curAudio = arg_8_1

	local var_8_0 = CharacterDataConfig.instance:getCharacterVoiceCO(arg_8_0._heroId, arg_8_0._curAudio)

	arg_8_0._uiSpine:stopVoice()
	CharacterDataModel.instance:setCurHeroAudioPlaying(arg_8_1)

	if var_8_0.type == CharacterEnum.VoiceType.FightBehit then
		local var_8_1 = AudioMgr.instance:getIdFromString("Hitvoc")
		local var_8_2 = AudioMgr.instance:getIdFromString("Uihitvoc")

		arg_8_0._uiSpine:setSwitch(var_8_1, var_8_2)
	elseif var_8_0.type == CharacterEnum.VoiceType.FightCardStar12 or var_8_0.type == CharacterEnum.VoiceType.FightCardStar3 or var_8_0.type == CharacterEnum.VoiceType.FightCardUnique then
		local var_8_3 = AudioMgr.instance:getIdFromString("card_voc")
		local var_8_4 = AudioMgr.instance:getIdFromString("uicardvoc")

		arg_8_0._uiSpine:setSwitch(var_8_3, var_8_4)
	end

	arg_8_0._uiSpine:playVoice(var_8_0, function()
		CharacterDataModel.instance:setCurHeroAudioFinished(arg_8_0._curAudio)
		arg_8_0:_refreshVoice()
	end, arg_8_0._txtvoicecontent, arg_8_0._txtvoiceengcontent)
	arg_8_0:_refreshVoice()

	local var_8_5 = arg_8_0.viewParam and type(arg_8_0.viewParam) == "table" and arg_8_0.viewParam.fromHandbookView

	CharacterController.instance:statCharacterData(StatEnum.EventName.PlayerVoice, arg_8_0._heroId, arg_8_1, nil, var_8_5)
	arg_8_0:_setTextVisible(true)
end

function var_0_0._setTextVisible(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._txtvoicecontent.gameObject, arg_10_1)

	local var_10_0 = (GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN or GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.TW) and arg_10_1

	gohelper.setActive(arg_10_0._txtvoiceengcontent.gameObject, var_10_0)
end

function var_0_0._onStopVoice(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
		arg_11_0:_unloadBnk()
	end

	CharacterDataModel.instance:setCurHeroAudioFinished(arg_11_1)
	arg_11_0._uiSpine:stopVoice()
	arg_11_0:_refreshVoice()
end

function var_0_0._disableClipAlpha(arg_12_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function var_0_0.onOpen(arg_13_0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	arg_13_0._animator:Play("voiceview_in", 0, 0)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	arg_13_0:_refreshUI()

	arg_13_0.filterDropExtend = DropDownExtend.Get(arg_13_0._dropfilter.gameObject)

	arg_13_0.filterDropExtend:init(arg_13_0.onFilterDropShow, arg_13_0.onFilterDropHide, arg_13_0)
	arg_13_0:initLanguageOptions()

	if not arg_13_0._uiSpine then
		return
	end

	arg_13_0:_setModelVisible(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_voice_open)
end

function var_0_0._resetNeedItemAnimState(arg_14_0)
	CharacterVoiceModel.instance:setNeedItemAni(false)

	arg_14_0._scroll.vertical = true

	arg_14_0:_disableClipAlpha()
end

function var_0_0._refreshUI(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._resetNeedItemAnimState, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._resetNeedItemAnimState, arg_15_0, 1.07)

	arg_15_0._scroll.vertical = false

	arg_15_0:_refreshVoice()

	if arg_15_0._heroId and arg_15_0._heroId == CharacterDataModel.instance:getCurHeroId() then
		return
	end

	arg_15_0._heroId = CharacterDataModel.instance:getCurHeroId()

	local var_15_0 = HeroModel.instance:getByHeroId(arg_15_0._heroId).config.signature

	arg_15_0:_refreshInfo()
	arg_15_0:_refreshSpine()
end

function var_0_0._refreshInfo(arg_16_0)
	arg_16_0._txtcast.text = HeroModel.instance:getByHeroId(arg_16_0._heroId).config.actor
end

function var_0_0._refreshSpine(arg_17_0)
	arg_17_0:_setTextVisible(false)

	local var_17_0 = HeroModel.instance:getByHeroId(arg_17_0._heroId)
	local var_17_1 = SkinConfig.instance:getSkinCo(var_17_0.skin)

	arg_17_0._uiSpine:setResPath(var_17_1, arg_17_0._onSpineLoaded, arg_17_0, CharacterVoiceEnum.FullScreenEffectCameraSize)

	local var_17_2 = var_17_1.characterDataVoiceViewOffset
	local var_17_3

	if string.nilorempty(var_17_2) then
		var_17_3 = SkinConfig.instance:getSkinOffset(var_17_1.characterViewOffset)
		var_17_3 = SkinConfig.instance:getAfterRelativeOffset(502, var_17_3)
	else
		var_17_3 = SkinConfig.instance:getSkinOffset(var_17_2)
	end

	recthelper.setAnchor(arg_17_0._gospine.transform, var_17_3[1], var_17_3[2])
	transformhelper.setLocalScale(arg_17_0._gospine.transform, var_17_3[3], var_17_3[3], var_17_3[3])
end

function var_0_0._onSpineLoaded(arg_18_0)
	arg_18_0:_onSpineLoaded_overseas()
end

function var_0_0._refreshVoice(arg_19_0)
	local var_19_0 = CharacterDataModel.instance:getCurHeroVoices()

	CharacterVoiceModel.instance:setVoiceList(var_19_0)
end

function var_0_0.initLanguageOptions(arg_20_0)
	arg_20_0._languageOptions = {
		LangSettings.en,
		LangSettings.zh
	}
	arg_20_0._languageOptions = {}

	local var_20_0 = GameConfig:GetSupportedVoiceShortcuts()
	local var_20_1 = var_20_0.Length

	for iter_20_0 = 0, var_20_1 - 1 do
		local var_20_2 = var_20_0[iter_20_0]
		local var_20_3 = SettingsVoicePackageModel.instance:getPackInfo(var_20_2)

		if var_20_3 and not var_20_3:needDownload() then
			local var_20_4 = LangSettings.shortCut2LangIdxTab[var_20_2]

			table.insert(arg_20_0._languageOptions, var_20_4)
		end
	end

	table.sort(arg_20_0._languageOptions, function(arg_21_0, arg_21_1)
		return arg_21_0 < arg_21_1
	end)

	arg_20_0._optionsName = {}

	local var_20_5 = 1
	local var_20_6 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_20_0._heroId)

	for iter_20_1, iter_20_2 in ipairs(arg_20_0._languageOptions) do
		if var_20_6 == iter_20_2 then
			arg_20_0._curLanguageId = iter_20_2
			var_20_5 = iter_20_1
		end

		local var_20_7 = luaLang(LangSettings.shortcutTab[iter_20_2])

		arg_20_0._optionsName[#arg_20_0._optionsName + 1] = var_20_7
	end

	arg_20_0._dropfilter:ClearOptions()
	arg_20_0._dropfilter:AddOptions(arg_20_0._optionsName)
	arg_20_0._dropfilter:SetValue(var_20_5 - 1)
	gohelper.setActive(arg_20_0._goarrowup, false)
end

function var_0_0._onDropFilterValueChanged(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 + 1

	if arg_22_0._languageOptions[arg_22_1] == arg_22_0._curLanguageId then
		return
	end

	local var_22_0 = LangSettings.shortcutTab[arg_22_0._languageOptions[arg_22_1]]
	local var_22_1 = SettingsVoicePackageModel.instance:getPackInfo(var_22_0)

	if var_22_1 and var_22_1:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		for iter_22_0, iter_22_1 in ipairs(arg_22_0._languageOptions) do
			if iter_22_1 == arg_22_0._curLanguageId then
				local var_22_2 = iter_22_0

				arg_22_0._dropfilter:SetValue(var_22_2 - 1)
			end
		end

		return
	end

	if arg_22_0._curAudio and arg_22_0._curAudio ~= 0 then
		arg_22_0._willChangeLangId = arg_22_0._languageOptions[arg_22_1]

		arg_22_0:_onStopVoice(arg_22_0._curAudio, true)

		arg_22_0._willChangeLangId = nil
	end

	arg_22_0._curLanguageId = arg_22_0._languageOptions[arg_22_1]

	SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(arg_22_0._curLanguageId, arg_22_0._heroId)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	CharacterController.instance:dispatchEvent(CharacterEvent.ChangeVoiceLang)
	UIBlockMgr.instance:startBlock(var_0_1)
	gohelper.setActive(arg_22_0._goDropEffect, false)
	gohelper.setActive(arg_22_0._goDropEffect, true)
	TaskDispatcher.runDelay(arg_22_0._refreshVoiceListEnd, arg_22_0, 0.6)
end

function var_0_0.onFilterDropShow(arg_23_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_23_0._isPopUpFilterList = true

	arg_23_0:refreshFilterDropDownArrow()

	local var_23_0 = gohelper.findChild(arg_23_0._dropfilter.gameObject, "Dropdown List/Viewport/Content").transform

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._languageOptions) do
		local var_23_1 = var_23_0:GetChild(iter_23_0)
		local var_23_2 = gohelper.findChildText(var_23_1.gameObject, "Text")
		local var_23_3 = LangSettings.shortcutTab[iter_23_1]
		local var_23_4 = SettingsVoicePackageModel.instance:getPackInfo(var_23_3)

		if var_23_4 and var_23_4:needDownload() then
			local var_23_5 = gohelper.findChild(var_23_1.gameObject, "#btn_download")

			gohelper.setActive(var_23_5, true)

			var_23_2.alpha = 0.5
		end

		if iter_23_1 == arg_23_0._curLanguageId then
			var_23_2.text = string.format("<color=#efb785ff>%s</color>", arg_23_0._optionsName[iter_23_0])
		else
			var_23_2.text = string.format("<color=#c3beb6ff>%s</color>", arg_23_0._optionsName[iter_23_0])
		end
	end
end

function var_0_0.onFilterDropHide(arg_24_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_24_0._isPopUpFilterList = false

	arg_24_0:refreshFilterDropDownArrow()
end

function var_0_0._refreshVoiceListEnd(arg_25_0)
	CharacterVoiceModel.instance:setNeedItemAni(false)
	UIBlockMgr.instance:endBlock(var_0_1)
end

function var_0_0.refreshFilterDropDownArrow(arg_26_0)
	gohelper.setActive(arg_26_0._goarrowdown, not arg_26_0._isPopUpFilterList)
	gohelper.setActive(arg_26_0._goarrowup, arg_26_0._isPopUpFilterList)
end

function var_0_0.onUpdateParam(arg_27_0)
	arg_27_0:_refreshUI()
end

function var_0_0.onClose(arg_28_0)
	CharacterDataModel.instance:setPlayingInfo(nil, nil)
	FrameTimerController.onDestroyViewMember(arg_28_0, "_frameTimer")
	CharacterVoiceModel.instance:setNeedItemAni(true)
	UIBlockMgr.instance:endBlock(var_0_1)

	if not arg_28_0._uiSpine then
		return
	end

	arg_28_0._uiSpine:stopVoice()
	arg_28_0:_setModelVisible(false)
end

function var_0_0._setModelVisible(arg_29_0, arg_29_1)
	TaskDispatcher.cancelTask(arg_29_0._delaySetModelHide, arg_29_0)

	if arg_29_1 then
		arg_29_0._uiSpine:setLayer(UnityLayer.Unit)
		arg_29_0._uiSpine:setModelVisible(arg_29_1)
	else
		arg_29_0._uiSpine:setLayer(UnityLayer.Water)
		arg_29_0._uiSpine:hideCamera()
		TaskDispatcher.runDelay(arg_29_0._delaySetModelHide, arg_29_0, 1)
	end
end

function var_0_0._delaySetModelHide(arg_30_0)
	if arg_30_0._uiSpine then
		arg_30_0._uiSpine:setModelVisible(false)
	end
end

function var_0_0.onDestroyView(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._resetNeedItemAnimState, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._refreshVoiceListEnd, arg_31_0)
	arg_31_0._simagebg:UnLoadImage()
	arg_31_0._simagecentericon:UnLoadImage()
	arg_31_0._simagelefticon:UnLoadImage()
	arg_31_0._simagerighticon:UnLoadImage()
	arg_31_0._simagerighticon2:UnLoadImage()
	arg_31_0._simagemask:UnLoadImage()
	arg_31_0._simagevoicebg:UnLoadImage()

	if arg_31_0._uiSpine then
		arg_31_0._uiSpine = nil
	end

	CharacterController.instance:unregisterCallback(CharacterEvent.PlayVoice, arg_31_0._onPlayVoice, arg_31_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.StopVoice, arg_31_0._onStopVoice, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._delaySetModelHide, arg_31_0)
end

return var_0_0
