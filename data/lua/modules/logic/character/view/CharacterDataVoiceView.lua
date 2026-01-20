-- chunkname: @modules/logic/character/view/CharacterDataVoiceView.lua

module("modules.logic.character.view.CharacterDataVoiceView", package.seeall)

local CharacterDataVoiceView = class("CharacterDataVoiceView", BaseView)
local RefreshVoiceListBlock = "RefreshVoiceListBlock"

function CharacterDataVoiceView:_onSpineLoaded_overseas()
	if not self._uiSpine:isLive2D() then
		return
	end

	local guiLive2d = self._uiSpine._curModel

	if not guiLive2d then
		return
	end

	self._charactercontainerTrans = gohelper.findChild(self.viewGO, "content/#simage_characterbg/charactercontainer").transform

	local lastPosX = self._charactercontainerTrans.localPosition.x

	FrameTimerController.onDestroyViewMember(self, "_frameTimer")

	self._frameTimer = FrameTimerController.instance:register(function(Self)
		Self:_doProcessEffect()

		local rootList = Self._uiEffectGos

		if not rootList then
			return
		end

		local posX = self._charactercontainerTrans.localPosition.x

		if math.abs(posX - lastPosX) <= 0.1 then
			return
		end

		lastPosX = posX

		for _, root in ipairs(rootList) do
			transformhelper.setLocalPosXY(root.transform, 0, 0)
			Self:_adjustPos(root, root)

			local s = Self._uiEffectConfig.scale

			transformhelper.setLocalScale(root.transform, s, s, s)
		end
	end, guiLive2d, 8, 5)

	self._frameTimer:Start()
end

function CharacterDataVoiceView:_unloadBnk()
	if not self._curAudio or self._curAudio == 0 then
		return
	end

	local audioCfg = AudioConfig.instance:getAudioCOById(self._curAudio)

	if not audioCfg then
		return
	end

	if not self._willChangeLangId then
		return
	end

	local bankName = audioCfg.bankName
	local playingLangStr = AudioMgr.instance:getLangByAudioId(self._curAudio)
	local playingLangId = LangSettings.shortCut2LangIdxTab[playingLangStr]

	if playingLangId ~= self._willChangeLangId then
		ZProj.AudioManager.Instance:UnloadBank(bankName)
		AudioMgr.instance:clearUnusedBanks()
	end
end

function CharacterDataVoiceView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simagecentericon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_centericon")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_mask")
	self._simagevoicebg = gohelper.findChildSingleImage(self.viewGO, "content/#simage_voicebg")
	self._txtvoicecontent = gohelper.findChildText(self.viewGO, "content/#txt_voicecontent")
	self._txtvoiceengcontent = gohelper.findChildText(self.viewGO, "content/#txt_voicecontent/#txt_voiceengcontent")
	self._txtcast = gohelper.findChildText(self.viewGO, "content/cast/#txt_cast")
	self._gospine = gohelper.findChild(self.viewGO, "content/#simage_characterbg/charactercontainer/#go_spine")
	self._dropfilter = gohelper.findChildDropdown(self.viewGO, "dropvoicelang")
	self._goDropEffect = gohelper.findChild(self.viewGO, "dropvoicelang/eff")
	self._goarrowdown = gohelper.findChild(self.viewGO, "dropvoicelang/arrow")
	self._goarrowup = gohelper.findChild(self.viewGO, "dropvoicelang/arrowUp")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDataVoiceView:addEvents()
	self._dropfilter:AddOnValueChanged(self._onDropFilterValueChanged, self)
end

function CharacterDataVoiceView:removeEvents()
	self._dropfilter:RemoveOnValueChanged()
end

function CharacterDataVoiceView:_editableInitView()
	self._scroll = gohelper.findChild(self.viewGO, "content/#scroll_vioce"):GetComponent(typeof(ZProj.LimitedScrollRect))

	self._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_2_ciecle.png"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	self._simagevoicebg:LoadImage(ResUrl.getCharacterDataIcon("bg_yuyingdizidi_035.png"))

	self._curAudio = 0
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:openBloomView(CharacterVoiceEnum.UIBloomView.CharacterDataView)
	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.BloomAuto)
	CharacterController.instance:registerCallback(CharacterEvent.PlayVoice, self._onPlayVoice, self)
	CharacterController.instance:registerCallback(CharacterEvent.StopVoice, self._onStopVoice, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterDataVoiceView:_onPlayVoice(audioId)
	self._curAudio = audioId

	local config = CharacterDataConfig.instance:getCharacterVoiceCO(self._heroId, self._curAudio)

	self._uiSpine:stopVoice()
	CharacterDataModel.instance:setCurHeroAudioPlaying(audioId)

	if config.type == CharacterEnum.VoiceType.FightBehit then
		local switchGroup = AudioMgr.instance:getIdFromString("Hitvoc")
		local switchState = AudioMgr.instance:getIdFromString("Uihitvoc")

		self._uiSpine:setSwitch(switchGroup, switchState)
	elseif config.type == CharacterEnum.VoiceType.FightCardStar12 or config.type == CharacterEnum.VoiceType.FightCardStar3 or config.type == CharacterEnum.VoiceType.FightCardUnique then
		local switchGroup = AudioMgr.instance:getIdFromString("card_voc")
		local switchState = AudioMgr.instance:getIdFromString("uicardvoc")

		self._uiSpine:setSwitch(switchGroup, switchState)
	end

	self._uiSpine:playVoice(config, function()
		CharacterDataModel.instance:setCurHeroAudioFinished(self._curAudio)
		self:_refreshVoice()
	end, self._txtvoicecontent, self._txtvoiceengcontent)
	self:_refreshVoice()

	local isHandbook = self.viewParam and type(self.viewParam) == "table" and self.viewParam.fromHandbookView

	CharacterController.instance:statCharacterData(StatEnum.EventName.PlayerVoice, self._heroId, audioId, nil, isHandbook)
	self:_setTextVisible(true)
end

function CharacterDataVoiceView:_setTextVisible(value)
	gohelper.setActive(self._txtvoicecontent.gameObject, value)

	local isShow = (GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN or GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.TW) and value

	gohelper.setActive(self._txtvoiceengcontent.gameObject, isShow)
end

function CharacterDataVoiceView:_onStopVoice(audioId, immediately)
	if immediately then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
		self:_unloadBnk()
	end

	CharacterDataModel.instance:setCurHeroAudioFinished(audioId)
	self._uiSpine:stopVoice()
	self:_refreshVoice()
end

function CharacterDataVoiceView:_disableClipAlpha()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function CharacterDataVoiceView:onOpen()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	self._animator:Play("voiceview_in", 0, 0)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	self:_refreshUI()

	self.filterDropExtend = DropDownExtend.Get(self._dropfilter.gameObject)

	self.filterDropExtend:init(self.onFilterDropShow, self.onFilterDropHide, self)
	self:initLanguageOptions()

	if not self._uiSpine then
		return
	end

	self:_setModelVisible(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_voice_open)
end

function CharacterDataVoiceView:_resetNeedItemAnimState()
	CharacterVoiceModel.instance:setNeedItemAni(false)

	self._scroll.vertical = true

	self:_disableClipAlpha()
end

function CharacterDataVoiceView:_refreshUI()
	TaskDispatcher.cancelTask(self._resetNeedItemAnimState, self)
	TaskDispatcher.runDelay(self._resetNeedItemAnimState, self, 1.07)

	self._scroll.vertical = false

	self:_refreshVoice()

	if self._heroId and self._heroId == CharacterDataModel.instance:getCurHeroId() then
		return
	end

	self._heroId = CharacterDataModel.instance:getCurHeroId()

	local signature = HeroModel.instance:getByHeroId(self._heroId).config.signature

	self:_refreshInfo()
	self:_refreshSpine()
end

function CharacterDataVoiceView:_refreshInfo()
	self._txtcast.text = HeroModel.instance:getByHeroId(self._heroId).config.actor
end

function CharacterDataVoiceView:_refreshSpine()
	self:_setTextVisible(false)

	local heroinfo = HeroModel.instance:getByHeroId(self._heroId)
	local skinCo = SkinConfig.instance:getSkinCo(heroinfo.skin)

	self._uiSpine:setResPath(skinCo, self._onSpineLoaded, self, CharacterVoiceEnum.FullScreenEffectCameraSize)

	local offsetStr = skinCo.characterDataVoiceViewOffset
	local offsets

	if string.nilorempty(offsetStr) then
		offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)
		offsets = SkinConfig.instance:getAfterRelativeOffset(502, offsets)
	else
		offsets = SkinConfig.instance:getSkinOffset(offsetStr)
	end

	recthelper.setAnchor(self._gospine.transform, offsets[1], offsets[2])
	transformhelper.setLocalScale(self._gospine.transform, offsets[3], offsets[3], offsets[3])
end

function CharacterDataVoiceView:_onSpineLoaded()
	self:_onSpineLoaded_overseas()
end

function CharacterDataVoiceView:_refreshVoice()
	local voices = CharacterDataModel.instance:getCurHeroVoices()

	CharacterVoiceModel.instance:setVoiceList(voices)
end

function CharacterDataVoiceView:initLanguageOptions()
	self._languageOptions = {
		LangSettings.en,
		LangSettings.zh
	}
	self._languageOptions = {}

	local cSharpArr = GameConfig:GetSupportedVoiceShortcuts()
	local length = cSharpArr.Length

	for i = 0, length - 1 do
		local langStr = cSharpArr[i]
		local packInfo = SettingsVoicePackageModel.instance:getPackInfo(langStr)

		if packInfo and not packInfo:needDownload() then
			local langId = LangSettings.shortCut2LangIdxTab[langStr]

			table.insert(self._languageOptions, langId)
		end
	end

	table.sort(self._languageOptions, function(a, b)
		return a < b
	end)

	self._optionsName = {}

	local initOptionIdx = 1
	local charVoiceLangId = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(self._heroId)

	for idx, languageId in ipairs(self._languageOptions) do
		if charVoiceLangId == languageId then
			self._curLanguageId = languageId
			initOptionIdx = idx
		end

		local filterTypeName = luaLang(LangSettings.shortcutTab[languageId])

		self._optionsName[#self._optionsName + 1] = filterTypeName
	end

	self._dropfilter:ClearOptions()
	self._dropfilter:AddOptions(self._optionsName)
	self._dropfilter:SetValue(initOptionIdx - 1)
	gohelper.setActive(self._goarrowup, false)
end

function CharacterDataVoiceView:_onDropFilterValueChanged(index)
	index = index + 1

	if self._languageOptions[index] == self._curLanguageId then
		return
	end

	local curSelectLangStr = LangSettings.shortcutTab[self._languageOptions[index]]
	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(curSelectLangStr)

	if packInfo and packInfo:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		for idx, languageId in ipairs(self._languageOptions) do
			if languageId == self._curLanguageId then
				local oriIndex = idx

				self._dropfilter:SetValue(oriIndex - 1)
			end
		end

		return
	end

	if self._curAudio and self._curAudio ~= 0 then
		self._willChangeLangId = self._languageOptions[index]

		self:_onStopVoice(self._curAudio, true)

		self._willChangeLangId = nil
	end

	self._curLanguageId = self._languageOptions[index]

	SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(self._curLanguageId, self._heroId)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	CharacterController.instance:dispatchEvent(CharacterEvent.ChangeVoiceLang)
	UIBlockMgr.instance:startBlock(RefreshVoiceListBlock)
	gohelper.setActive(self._goDropEffect, false)
	gohelper.setActive(self._goDropEffect, true)
	TaskDispatcher.runDelay(self._refreshVoiceListEnd, self, 0.6)
end

function CharacterDataVoiceView:onFilterDropShow()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	self._isPopUpFilterList = true

	self:refreshFilterDropDownArrow()

	local optionListContentTrans = gohelper.findChild(self._dropfilter.gameObject, "Dropdown List/Viewport/Content").transform

	for idx, languageId in ipairs(self._languageOptions) do
		local optionTrans = optionListContentTrans:GetChild(idx)
		local optionText = gohelper.findChildText(optionTrans.gameObject, "Text")
		local curSelectLangStr = LangSettings.shortcutTab[languageId]
		local packInfo = SettingsVoicePackageModel.instance:getPackInfo(curSelectLangStr)

		if packInfo and packInfo:needDownload() then
			local downloadGo = gohelper.findChild(optionTrans.gameObject, "#btn_download")

			gohelper.setActive(downloadGo, true)

			optionText.alpha = 0.5
		end

		if languageId == self._curLanguageId then
			optionText.text = string.format("<color=#efb785ff>%s</color>", self._optionsName[idx])
		else
			optionText.text = string.format("<color=#c3beb6ff>%s</color>", self._optionsName[idx])
		end
	end
end

function CharacterDataVoiceView:onFilterDropHide()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	self._isPopUpFilterList = false

	self:refreshFilterDropDownArrow()
end

function CharacterDataVoiceView:_refreshVoiceListEnd()
	CharacterVoiceModel.instance:setNeedItemAni(false)
	UIBlockMgr.instance:endBlock(RefreshVoiceListBlock)
end

function CharacterDataVoiceView:refreshFilterDropDownArrow()
	gohelper.setActive(self._goarrowdown, not self._isPopUpFilterList)
	gohelper.setActive(self._goarrowup, self._isPopUpFilterList)
end

function CharacterDataVoiceView:onUpdateParam()
	self:_refreshUI()
end

function CharacterDataVoiceView:onClose()
	CharacterDataModel.instance:setPlayingInfo(nil, nil)
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	CharacterVoiceModel.instance:setNeedItemAni(true)
	UIBlockMgr.instance:endBlock(RefreshVoiceListBlock)

	if not self._uiSpine then
		return
	end

	self._uiSpine:stopVoice()
	self:_setModelVisible(false)
end

function CharacterDataVoiceView:_setModelVisible(value)
	TaskDispatcher.cancelTask(self._delaySetModelHide, self)

	if value then
		self._uiSpine:setLayer(UnityLayer.Unit)
		self._uiSpine:setModelVisible(value)
	else
		self._uiSpine:setLayer(UnityLayer.Water)
		self._uiSpine:hideCamera()
		TaskDispatcher.runDelay(self._delaySetModelHide, self, 1)
	end
end

function CharacterDataVoiceView:_delaySetModelHide()
	if self._uiSpine then
		self._uiSpine:setModelVisible(false)
	end
end

function CharacterDataVoiceView:onDestroyView()
	TaskDispatcher.cancelTask(self._resetNeedItemAnimState, self)
	TaskDispatcher.cancelTask(self._refreshVoiceListEnd, self)
	self._simagebg:UnLoadImage()
	self._simagecentericon:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagevoicebg:UnLoadImage()

	if self._uiSpine then
		self._uiSpine = nil
	end

	CharacterController.instance:unregisterCallback(CharacterEvent.PlayVoice, self._onPlayVoice, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.StopVoice, self._onStopVoice, self)
	TaskDispatcher.cancelTask(self._delaySetModelHide, self)
end

return CharacterDataVoiceView
