-- chunkname: @modules/spine/SpineVoice.lua

module("modules.spine.SpineVoice", package.seeall)

local SpineVoice = class("SpineVoice")

function SpineVoice:ctor()
	self._componentStopVoiceCount = 0
	self._spineVoiceText = self:_addComponent(SpineVoiceText)
	self._spineVoiceBody = self:_addComponent(SpineVoiceBody, true)
	self._spineVoiceAudio = self:_addComponent(SpineVoiceAudio, true)

	self:_init()
end

function SpineVoice:_init()
	self._spineVoiceMouth = self:_addComponent(SpineVoiceMouth, true)
	self._voiceFace = self:_addComponent(SpineVoiceFace, true)
end

function SpineVoice:_addComponent(cls, canStopVoice)
	if canStopVoice then
		self._componentStopVoiceCount = self._componentStopVoiceCount + 1
	end

	return cls.New()
end

function SpineVoice:stopVoice()
	self._manualStopVoice = true

	if not self._playVoice then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	self:_onVoiceStop()
end

function SpineVoice:setDiffFaceBiYan(needBiyan)
	self._voiceFace:setDiffFaceBiYan(needBiyan)
end

function SpineVoice:setInStory()
	self._isInStory = true
end

function SpineVoice:getInStory()
	return self._isInStory
end

function SpineVoice:getVoiceLang()
	return self._lang
end

function SpineVoice:getPlayVoiceStartTime()
	return self._playVoiceStartTime
end

function SpineVoice:playVoice(spine, voiceConfig, callback, txtContent, txtEnContent, bgGo, showBg)
	if voiceConfig and voiceConfig.audio then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	end

	self._playVoiceStartTime = Time.time
	self._playVoice = true
	self._manualStopVoice = false
	self._stopVoiceCount = 0
	self._callback = callback
	self._spine = spine
	self._voiceConfig = voiceConfig
	self._txtContent = txtContent
	self._txtEnContent = txtEnContent
	self._bgGo = bgGo
	self._showBg = showBg

	self:setBgVisible(true)
	self._spine:stopTransition()

	local heroId = voiceConfig.heroId

	if heroId then
		local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
		local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]
		local curLang = GameConfig:GetCurVoiceShortcut()

		if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
			self._spineVoiceAudio:init(self, voiceConfig, spine, charVoiceLang)
		else
			self._spineVoiceAudio:init(self, voiceConfig, spine)
		end
	else
		self._spineVoiceAudio:init(self, voiceConfig, spine)
	end

	if self._spineVoiceAudio:hasAudio() then
		self._lang = AudioMgr.instance:getLangByAudioId(voiceConfig.audio)
	else
		self._lang = AudioMgr.instance:getCurLang()
	end

	if txtContent or txtEnContent then
		self._spineVoiceText:init(self, voiceConfig, txtContent, txtEnContent, showBg)
	end

	self:_initSpineVoiceMouth(voiceConfig, spine)
	self._voiceFace:init(self, voiceConfig, spine)

	if voiceConfig.noChangeBody ~= true or not self._spineVoiceBody:getSpineVoice() then
		self._spineVoiceBody:init(self, voiceConfig, spine)
	end
end

function SpineVoice:_initSpineVoiceMouth(voiceConfig, spine)
	self._spineVoiceMouth:init(self, voiceConfig, spine)
end

function SpineVoice:setSwitch(spine, switchGroup, switchState)
	self._spineVoiceAudio:setSwitch(spine, switchGroup, switchState)
end

function SpineVoice:playing()
	return self._playVoice
end

function SpineVoice:onSpineVoiceAudioStop()
	self._spineVoiceText:onVoiceStop()
	self:_doCallback()
end

function SpineVoice:_onComponentStop(component)
	self._stopVoiceCount = self._stopVoiceCount + 1

	if self._stopVoiceCount >= self._componentStopVoiceCount then
		self:_onVoiceStop()
	end
end

function SpineVoice:forceNoMouth()
	self._spineVoiceMouth:forceNoMouth()
end

function SpineVoice:_onVoiceStop()
	if not self._playVoice then
		return
	end

	self._playVoice = false

	self._spineVoiceAudio:onVoiceStop()
	self._spineVoiceMouth:onVoiceStop()
	self._spineVoiceText:onVoiceStop()
	self._voiceFace:onVoiceStop()
	self._spineVoiceBody:onVoiceStop()
	self:_doCallback()
end

function SpineVoice:_doCallback()
	local callback = self._callback

	self._callback = nil

	if callback then
		callback()
	end
end

function SpineVoice:setBgVisible(value)
	gohelper.setActive(self._bgGo, value)
end

function SpineVoice:onAnimationEvent(actName, evtName, args)
	if evtName ~= SpineAnimEvent.ActionComplete then
		return
	end

	if self._manualStopVoice then
		return
	end

	if self._voiceFace:checkFaceEnd(actName) then
		return
	end

	if self._spineVoiceBody:checkBodyEnd(actName) then
		return
	end

	if self._spineVoiceMouth:checkMouthEnd(actName) then
		return
	end
end

function SpineVoice:onDestroy()
	if self._spineVoiceText then
		self._spineVoiceText:onDestroy()

		self._spineVoiceText = nil
	end

	if self._spineVoiceMouth then
		self._spineVoiceMouth:onDestroy()

		self._spineVoiceMouth = nil
	end

	if self._voiceFace then
		self._voiceFace:onDestroy()

		self._voiceFace = nil
	end

	if self._spineVoiceBody then
		self._spineVoiceBody:onDestroy()

		self._spineVoiceBody = nil
	end

	if self._spineVoiceAudio then
		self._spineVoiceAudio:onDestroy()

		self._spineVoiceAudio = nil
	end

	self._spine = nil
end

return SpineVoice
