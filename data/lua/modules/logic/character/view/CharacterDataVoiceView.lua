module("modules.logic.character.view.CharacterDataVoiceView", package.seeall)

slot0 = class("CharacterDataVoiceView", BaseView)
slot1 = "RefreshVoiceListBlock"

function slot0._onSpineLoaded_overseas(slot0)
	if not slot0._uiSpine:isLive2D() then
		return
	end

	if not slot0._uiSpine._curModel then
		return
	end

	slot0._charactercontainerTrans = gohelper.findChild(slot0.viewGO, "content/#simage_characterbg/charactercontainer").transform
	slot2 = slot0._charactercontainerTrans.localPosition.x

	FrameTimerController.onDestroyViewMember(slot0, "_frameTimer")

	slot0._frameTimer = FrameTimerController.instance:register(function (slot0)
		slot0:_doProcessEffect()

		if not slot0._uiEffectGos then
			return
		end

		if math.abs(uv0._charactercontainerTrans.localPosition.x - uv1) <= 0.1 then
			return
		end

		uv1 = slot2

		for slot6, slot7 in ipairs(slot1) do
			transformhelper.setLocalPosXY(slot7.transform, 0, 0)
			slot0:_adjustPos(slot7, slot7)

			slot8 = slot0._uiEffectConfig.scale

			transformhelper.setLocalScale(slot7.transform, slot8, slot8, slot8)
		end
	end, slot1, 8, 5)

	slot0._frameTimer:Start()
end

function slot0._unloadBnk(slot0)
	if not slot0._curAudio or slot0._curAudio == 0 then
		return
	end

	if not AudioConfig.instance:getAudioCOById(slot0._curAudio) then
		return
	end

	if not slot0._willChangeLangId then
		return
	end

	if LangSettings.shortCut2LangIdxTab[AudioMgr.instance:getLangByAudioId(slot0._curAudio)] ~= slot0._willChangeLangId then
		ZProj.AudioManager.Instance:UnloadBank(slot1.bankName)
		AudioMgr.instance:clearUnusedBanks()
	end
end

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simagecentericon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_centericon")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_mask")
	slot0._simagevoicebg = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_voicebg")
	slot0._txtvoicecontent = gohelper.findChildText(slot0.viewGO, "content/#txt_voicecontent")
	slot0._txtvoiceengcontent = gohelper.findChildText(slot0.viewGO, "content/#txt_voicecontent/#txt_voiceengcontent")
	slot0._txtcast = gohelper.findChildText(slot0.viewGO, "content/cast/#txt_cast")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "content/#simage_characterbg/charactercontainer/#go_spine")
	slot0._dropfilter = gohelper.findChildDropdown(slot0.viewGO, "dropvoicelang")
	slot0._goDropEffect = gohelper.findChild(slot0.viewGO, "dropvoicelang/eff")
	slot0._goarrowdown = gohelper.findChild(slot0.viewGO, "dropvoicelang/arrow")
	slot0._goarrowup = gohelper.findChild(slot0.viewGO, "dropvoicelang/arrowUp")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._dropfilter:AddOnValueChanged(slot0._onDropFilterValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._dropfilter:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._scroll = gohelper.findChild(slot0.viewGO, "content/#scroll_vioce"):GetComponent(typeof(ZProj.LimitedScrollRect))

	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_2_ciecle.png"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	slot0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	slot0._simagevoicebg:LoadImage(ResUrl.getCharacterDataIcon("bg_yuyingdizidi_035.png"))

	slot0._curAudio = 0
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)

	CharacterController.instance:registerCallback(CharacterEvent.PlayVoice, slot0._onPlayVoice, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.StopVoice, slot0._onStopVoice, slot0)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._onPlayVoice(slot0, slot1)
	slot0._curAudio = slot1

	slot0._uiSpine:stopVoice()
	CharacterDataModel.instance:setCurHeroAudioPlaying(slot1)

	if CharacterDataConfig.instance:getCharacterVoiceCO(slot0._heroId, slot0._curAudio).type == CharacterEnum.VoiceType.FightBehit then
		slot0._uiSpine:setSwitch(AudioMgr.instance:getIdFromString("Hitvoc"), AudioMgr.instance:getIdFromString("Uihitvoc"))
	elseif slot2.type == CharacterEnum.VoiceType.FightCardStar12 or slot2.type == CharacterEnum.VoiceType.FightCardStar3 or slot2.type == CharacterEnum.VoiceType.FightCardUnique then
		slot0._uiSpine:setSwitch(AudioMgr.instance:getIdFromString("card_voc"), AudioMgr.instance:getIdFromString("uicardvoc"))
	end

	slot0._uiSpine:playVoice(slot2, function ()
		CharacterDataModel.instance:setCurHeroAudioFinished(uv0._curAudio)
		uv0:_refreshVoice()
	end, slot0._txtvoicecontent, slot0._txtvoiceengcontent)
	slot0:_refreshVoice()
	CharacterController.instance:statCharacterData(StatEnum.EventName.PlayerVoice, slot0._heroId, slot1, nil, slot0.viewParam and type(slot0.viewParam) == "table" and slot0.viewParam.fromHandbookView)
	slot0:_setTextVisible(true)
end

function slot0._setTextVisible(slot0, slot1)
	gohelper.setActive(slot0._txtvoicecontent.gameObject, slot1)
	gohelper.setActive(slot0._txtvoiceengcontent.gameObject, (GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN or GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.TW) and slot1)
end

function slot0._onStopVoice(slot0, slot1, slot2)
	if slot2 then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
		slot0:_unloadBnk()
	end

	CharacterDataModel.instance:setCurHeroAudioFinished(slot1)
	slot0._uiSpine:stopVoice()
	slot0:_refreshVoice()
end

function slot0._disableClipAlpha(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function slot0.onOpen(slot0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	slot0._animator:Play("voiceview_in", 0, 0)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	slot0:_refreshUI()

	slot0.filterDropExtend = DropDownExtend.Get(slot0._dropfilter.gameObject)

	slot0.filterDropExtend:init(slot0.onFilterDropShow, slot0.onFilterDropHide, slot0)
	slot0:initLanguageOptions()

	if not slot0._uiSpine then
		return
	end

	slot0:_setModelVisible(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_voice_open)
end

function slot0._resetNeedItemAnimState(slot0)
	CharacterVoiceModel.instance:setNeedItemAni(false)

	slot0._scroll.vertical = true

	slot0:_disableClipAlpha()
end

function slot0._refreshUI(slot0)
	TaskDispatcher.cancelTask(slot0._resetNeedItemAnimState, slot0)
	TaskDispatcher.runDelay(slot0._resetNeedItemAnimState, slot0, 1.07)

	slot0._scroll.vertical = false

	slot0:_refreshVoice()

	if slot0._heroId and slot0._heroId == CharacterDataModel.instance:getCurHeroId() then
		return
	end

	slot0._heroId = CharacterDataModel.instance:getCurHeroId()
	slot1 = HeroModel.instance:getByHeroId(slot0._heroId).config.signature

	slot0:_refreshInfo()
	slot0:_refreshSpine()
end

function slot0._refreshInfo(slot0)
	slot0._txtcast.text = HeroModel.instance:getByHeroId(slot0._heroId).config.actor
end

function slot0._refreshSpine(slot0)
	slot0:_setTextVisible(false)

	slot2 = SkinConfig.instance:getSkinCo(HeroModel.instance:getByHeroId(slot0._heroId).skin)

	slot0._uiSpine:setResPath(slot2, slot0._onSpineLoaded, slot0)

	slot4 = nil
	slot4 = (not string.nilorempty(slot2.characterDataVoiceViewOffset) or SkinConfig.instance:getAfterRelativeOffset(502, SkinConfig.instance:getSkinOffset(slot2.characterViewOffset))) and SkinConfig.instance:getSkinOffset(slot3)

	recthelper.setAnchor(slot0._gospine.transform, slot4[1], slot4[2])
	transformhelper.setLocalScale(slot0._gospine.transform, slot4[3], slot4[3], slot4[3])
end

function slot0._onSpineLoaded(slot0)
	slot0:_onSpineLoaded_overseas()
end

function slot0._refreshVoice(slot0)
	CharacterVoiceModel.instance:setVoiceList(CharacterDataModel.instance:getCurHeroVoices())
end

function slot0.initLanguageOptions(slot0)
	slot0._languageOptions = {
		LangSettings.en,
		LangSettings.zh
	}
	slot0._languageOptions = {}

	for slot6 = 0, GameConfig:GetSupportedVoiceShortcuts().Length - 1 do
		if SettingsVoicePackageModel.instance:getPackInfo(slot1[slot6]) and not slot8:needDownload() then
			table.insert(slot0._languageOptions, LangSettings.shortCut2LangIdxTab[slot7])
		end
	end

	table.sort(slot0._languageOptions, function (slot0, slot1)
		return slot0 < slot1
	end)

	slot0._optionsName = {}
	slot3 = 1

	for slot8, slot9 in ipairs(slot0._languageOptions) do
		if SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot0._heroId) == slot9 then
			slot0._curLanguageId = slot9
			slot3 = slot8
		end

		slot0._optionsName[#slot0._optionsName + 1] = luaLang(LangSettings.shortcutTab[slot9])
	end

	slot0._dropfilter:ClearOptions()
	slot0._dropfilter:AddOptions(slot0._optionsName)
	slot0._dropfilter:SetValue(slot3 - 1)
	gohelper.setActive(slot0._goarrowup, false)
end

function slot0._onDropFilterValueChanged(slot0, slot1)
	if slot0._languageOptions[slot1 + 1] == slot0._curLanguageId then
		return
	end

	if SettingsVoicePackageModel.instance:getPackInfo(LangSettings.shortcutTab[slot0._languageOptions[slot1]]) and slot3:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		for slot7, slot8 in ipairs(slot0._languageOptions) do
			if slot8 == slot0._curLanguageId then
				slot0._dropfilter:SetValue(slot7 - 1)
			end
		end

		return
	end

	if slot0._curAudio and slot0._curAudio ~= 0 then
		slot0._willChangeLangId = slot0._languageOptions[slot1]

		slot0:_onStopVoice(slot0._curAudio, true)

		slot0._willChangeLangId = nil
	end

	slot0._curLanguageId = slot0._languageOptions[slot1]

	SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(slot0._curLanguageId, slot0._heroId)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	CharacterController.instance:dispatchEvent(CharacterEvent.ChangeVoiceLang)
	UIBlockMgr.instance:startBlock(uv0)
	gohelper.setActive(slot0._goDropEffect, false)
	gohelper.setActive(slot0._goDropEffect, true)
	TaskDispatcher.runDelay(slot0._refreshVoiceListEnd, slot0, 0.6)
end

function slot0.onFilterDropShow(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	slot0._isPopUpFilterList = true

	slot0:refreshFilterDropDownArrow()

	for slot5, slot6 in ipairs(slot0._languageOptions) do
		if SettingsVoicePackageModel.instance:getPackInfo(LangSettings.shortcutTab[slot6]) and slot10:needDownload() then
			gohelper.setActive(gohelper.findChild(slot7.gameObject, "#btn_download"), true)

			gohelper.findChildText(gohelper.findChild(slot0._dropfilter.gameObject, "Dropdown List/Viewport/Content").transform:GetChild(slot5).gameObject, "Text").alpha = 0.5
		end

		if slot6 == slot0._curLanguageId then
			slot8.text = string.format("<color=#efb785ff>%s</color>", slot0._optionsName[slot5])
		else
			slot8.text = string.format("<color=#c3beb6ff>%s</color>", slot0._optionsName[slot5])
		end
	end
end

function slot0.onFilterDropHide(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	slot0._isPopUpFilterList = false

	slot0:refreshFilterDropDownArrow()
end

function slot0._refreshVoiceListEnd(slot0)
	CharacterVoiceModel.instance:setNeedItemAni(false)
	UIBlockMgr.instance:endBlock(uv0)
end

function slot0.refreshFilterDropDownArrow(slot0)
	gohelper.setActive(slot0._goarrowdown, not slot0._isPopUpFilterList)
	gohelper.setActive(slot0._goarrowup, slot0._isPopUpFilterList)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	FrameTimerController.onDestroyViewMember(slot0, "_frameTimer")
	CharacterVoiceModel.instance:setNeedItemAni(true)
	UIBlockMgr.instance:endBlock(uv0)

	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:stopVoice()
	slot0:_setModelVisible(false)
end

function slot0._setModelVisible(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._delaySetModelHide, slot0)

	if slot1 then
		slot0._uiSpine:setLayer(UnityLayer.Unit)
		slot0._uiSpine:setModelVisible(slot1)
	else
		slot0._uiSpine:setLayer(UnityLayer.Water)
		TaskDispatcher.runDelay(slot0._delaySetModelHide, slot0, 1)
	end
end

function slot0._delaySetModelHide(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:setModelVisible(false)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._resetNeedItemAnimState, slot0)
	TaskDispatcher.cancelTask(slot0._refreshVoiceListEnd, slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagecentericon:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagevoicebg:UnLoadImage()

	if slot0._uiSpine then
		slot0._uiSpine = nil
	end

	CharacterController.instance:unregisterCallback(CharacterEvent.PlayVoice, slot0._onPlayVoice, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.StopVoice, slot0._onStopVoice, slot0)
	TaskDispatcher.cancelTask(slot0._delaySetModelHide, slot0)
end

return slot0
