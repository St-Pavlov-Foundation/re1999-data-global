-- chunkname: @modules/spine/SpineVoiceAudio.lua

module("modules.spine.SpineVoiceAudio", package.seeall)

local SpineVoiceAudio = class("SpineVoiceAudio")

function SpineVoiceAudio:ctor()
	return
end

function SpineVoiceAudio:onDestroy()
	self._spineVoice = nil
	self._voiceConfig = nil
	self._spine = nil
	self._addAudios = nil
end

function SpineVoiceAudio:init(spineVoice, voiceConfig, spine, lang)
	self._spineVoice = spineVoice
	self._voiceConfig = voiceConfig
	self._spine = spine
	self._hasAudio = AudioConfig.instance:getAudioCOById(voiceConfig.audio)

	if self._hasAudio then
		self._emitter = ZProj.AudioEmitter.Get(spine:getSpineGo())

		if not self._emitter then
			self:_onVoiceEnd()

			return
		end

		if lang then
			local curVoice = GameConfig:GetCurVoiceShortcut()
			local audioCfg = AudioConfig.instance:getAudioCOById(voiceConfig.audio)
			local eventName = audioCfg.eventName
			local bankName = audioCfg.bankName

			if SettingsModel.instance:isZhRegion() == false then
				if string.nilorempty(audioCfg.eventName_Overseas) == false then
					eventName = audioCfg.eventName_Overseas
				end

				if string.nilorempty(audioCfg.bankName_Overseas) == false then
					bankName = audioCfg.bankName_Overseas
				end
			end

			self._emitter:EmitterByName(bankName, eventName, lang, self._onEmitterCallback, self)
		else
			self._emitter:Emitter(voiceConfig.audio, self._onEmitterCallback, self)
		end

		print("playVoice:", voiceConfig.audio)
		AudioMgr.instance:addAudioLog(voiceConfig.audio, "yellow", "播放音效开始")
	else
		print("playVoice no audio:", voiceConfig.audio)
		self:_onVoiceEnd()
	end

	self._hasAddAudio = voiceConfig.addaudio and voiceConfig.addaudio ~= ""

	if self._hasAddAudio then
		self._addAudios = {}

		local curVoiceTypeIdx = GameLanguageMgr.instance:getVoiceTypeStoryIndex()

		if lang then
			curVoiceTypeIdx = GameLanguageMgr.instance:getStoryIndexByShortCut(lang)
		end

		local addAudiosParams = string.split(voiceConfig.addaudio, "|")

		for _, audioParam in pairs(addAudiosParams) do
			local params = string.splitToNumber(audioParam, "#")
			local audioId = params[1]
			local delayTime = params[curVoiceTypeIdx + 1]
			local audioItem = SpineVoiceAddAudio.New()

			audioItem:init(audioId, delayTime or 0)
			table.insert(self._addAudios, audioItem)
		end
	end
end

function SpineVoiceAudio:hasAudio()
	return self._hasAudio
end

function SpineVoiceAudio:setSwitch(spine, switchGroup, switchState)
	if not self._emitter then
		self._emitter = ZProj.AudioEmitter.Get(spine:getSpineGo())
	end

	if self._emitter then
		self._emitter:SetSwitch(switchGroup, switchState)
	end
end

function SpineVoiceAudio:_onEmitterCallback(callbackType, value)
	if callbackType == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif callbackType == AudioEnum.AkCallbackType.AK_EndOfEvent then
		self:_emitterStopVoice()
	end
end

function SpineVoiceAudio:_emitterStopVoice()
	self:_onVoiceEnd()
end

function SpineVoiceAudio:_onVoiceEnd()
	if not self._spineVoice then
		return
	end

	if self._hasAudio then
		self._spineVoice:onSpineVoiceAudioStop()
	end

	self._spineVoice:_onComponentStop(self)

	if self._hasAudio then
		AudioMgr.instance:addAudioLog(self._voiceConfig.audio, "green", "播放音效结束")
	end
end

function SpineVoiceAudio:getEmitter()
	if self._spine then
		if self._emitter == nil or gohelper.isNil(self._emitter) then
			self._emitter = ZProj.AudioEmitter.Get(self._spine:getSpineGo())
		end

		return self._emitter
	else
		return nil
	end
end

function SpineVoiceAudio:onVoiceStop()
	if self._addAudios then
		for _, audio in pairs(self._addAudios) do
			audio:onDestroy()
		end

		self._addAudios = nil
	end
end

return SpineVoiceAudio
