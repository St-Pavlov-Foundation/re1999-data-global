-- chunkname: @modules/logic/main/view/skininteraction/CommonSkinInteraction.lua

module("modules.logic.main.view.skininteraction.CommonSkinInteraction", package.seeall)

local CommonSkinInteraction = class("CommonSkinInteraction", BaseSkinInteraction)

function CommonSkinInteraction:_onInit()
	CommonSkinInteraction.super._onInit(self)

	local config = lua_skin_body_camera.configDict[self._skinId]

	if config then
		local behavior = config.behavior
		local cls = _G[behavior]

		self:_addBehavior(cls.New())
	end
end

function CommonSkinInteraction:_onClick(pos)
	self:_clickDefault(pos)
end

function CommonSkinInteraction:_isSpecialRespondType(type)
	return type == CharacterEnum.VoiceType.MainViewSpecialRespond or type == CharacterEnum.VoiceType.MainViewDragSpecialRespond
end

function CommonSkinInteraction:_beforePlayVoice(config)
	self._isRespondType = self._isSpecialInteraction and self:_isSpecialRespondType(config.type)
	self._changeValue = nil

	local isWaitVoice = config and config.audio == self._waitVoice and not self._skipChangeStatus

	if isWaitVoice then
		local value = CharacterVoiceController.instance:getChangeValue(config)

		self._changeValue = value
	end

	if self:_isSpecialRespondType(config.type) then
		CharacterVoiceController.instance:trackSpecialInteraction(config.heroId, config.audio, isWaitVoice and CharacterVoiceEnum.PlayType.Click or CharacterVoiceEnum.PlayType.Auto)
	end
end

function CommonSkinInteraction:_afterPlayVoice(config)
	if self._changeValue then
		PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, config.heroId, self._changeValue)

		local propertyStr = PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.SkinState)

		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.SkinState, propertyStr)
	end
end

function CommonSkinInteraction:_onPlayVoiceFinish(config)
	if self._isDragging then
		return
	end

	if self._isSpecialInteraction then
		TaskDispatcher.runDelay(self._waitTimeout, self, self._waitTime)
	end

	self._voiceConfig = nil
end

function CommonSkinInteraction:beginDrag()
	self._isDragging = true

	TaskDispatcher.cancelTask(self._waitTimeout, self)
end

function CommonSkinInteraction:endDrag()
	self._isDragging = false

	if self._isSpecialInteraction then
		TaskDispatcher.runDelay(self._waitTimeout, self, self._waitTime)
	end
end

function CommonSkinInteraction:_onPlayVoice()
	self:_onStopVoice()

	self._isSpecialInteraction = self._voiceConfig.type == CharacterEnum.VoiceType.MainViewSpecialInteraction

	if self._isSpecialInteraction then
		local id = tonumber(self._voiceConfig.param2)

		if not id then
			logError(string.format("CommonSkinInteraction _onPlayVoice param2:%s is error, voiceConfig: %s", self._voiceConfig.param2, tostring(self._voiceConfig.audio)))

			return
		end

		local config = lua_character_special_interaction_voice.configDict[id]

		self._startTime = Time.time
		self._protectionTime = config.protectionTime or 0
		self._waitTime = config.time
		self._waitVoice = config.waitVoice
		self._timeoutVoiceConfig = lua_character_voice.configDict[self._voiceConfig.heroId][config.timeoutVoice]
		self._skipChangeStatus = config.statusParams == CharacterVoiceEnum.StatusParams.Luxi_NoChangeStatus

		CharacterVoiceController.instance:trackSpecialInteraction(self._voiceConfig.heroId, self._voiceConfig.audio, CharacterVoiceController.instance:getSpecialInteractionPlayType())
	end
end

function CommonSkinInteraction:_waitTimeout()
	self._isSpecialInteraction = nil

	self:playVoice(self._timeoutVoiceConfig)
end

function CommonSkinInteraction:_onStopVoice()
	self._isSpecialInteraction = nil
	self._waitVoice = nil
	self._timeoutVoiceConfig = nil
	self._skipChangeStatus = nil

	TaskDispatcher.cancelTask(self._waitTimeout, self)
end

function CommonSkinInteraction:needRespond()
	return self._isSpecialInteraction
end

function CommonSkinInteraction:inProtectionTime()
	return self._isSpecialInteraction and Time.time - self._startTime <= self._protectionTime
end

function CommonSkinInteraction:canPlay(config)
	if self._isSpecialInteraction then
		if Time.time - self._startTime <= self._protectionTime then
			return false
		end

		return config.audio == self._waitVoice
	end

	if self._voiceConfig and self._isRespondType then
		return false
	end

	return true
end

function CommonSkinInteraction:_onDestroy()
	TaskDispatcher.cancelTask(self._waitTimeout, self)
end

return CommonSkinInteraction
