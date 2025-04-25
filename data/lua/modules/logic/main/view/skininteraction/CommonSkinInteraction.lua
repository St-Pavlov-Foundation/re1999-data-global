module("modules.logic.main.view.skininteraction.CommonSkinInteraction", package.seeall)

slot0 = class("CommonSkinInteraction", BaseSkinInteraction)

function slot0._onClick(slot0, slot1)
	slot0:_clickDefault(slot1)
end

function slot0._isSpecialRespondType(slot0, slot1)
	return slot1 == CharacterEnum.VoiceType.MainViewSpecialRespond or slot1 == CharacterEnum.VoiceType.MainViewDragSpecialRespond
end

function slot0._beforePlayVoice(slot0, slot1)
	slot0._isRespondType = slot0._isSpecialInteraction and slot0:_isSpecialRespondType(slot1.type)
	slot0._changeValue = nil

	if slot1 and slot1.audio == slot0._waitVoice then
		slot0._changeValue = CharacterVoiceController.instance:getChangeValue(slot1)
	end

	if slot0:_isSpecialRespondType(slot1.type) then
		CharacterVoiceController.instance:trackSpecialInteraction(slot1.heroId, slot1.audio, slot2 and CharacterVoiceEnum.PlayType.Click or CharacterVoiceEnum.PlayType.Auto)
	end
end

function slot0._afterPlayVoice(slot0, slot1)
	if slot0._changeValue then
		PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot1.heroId, slot0._changeValue)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.SkinState, PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.SkinState))
	end
end

function slot0._onPlayVoiceFinish(slot0, slot1)
	if slot0._isDragging then
		return
	end

	if slot0._isSpecialInteraction then
		TaskDispatcher.runDelay(slot0._waitTimeout, slot0, slot0._waitTime)
	end

	slot0._voiceConfig = nil
end

function slot0.beginDrag(slot0)
	slot0._isDragging = true

	TaskDispatcher.cancelTask(slot0._waitTimeout, slot0)
end

function slot0.endDrag(slot0)
	slot0._isDragging = false

	if slot0._isSpecialInteraction then
		TaskDispatcher.runDelay(slot0._waitTimeout, slot0, slot0._waitTime)
	end
end

function slot0._onPlayVoice(slot0)
	slot0:_onStopVoice()

	slot0._isSpecialInteraction = slot0._voiceConfig.type == CharacterEnum.VoiceType.MainViewSpecialInteraction

	if slot0._isSpecialInteraction then
		if not tonumber(slot0._voiceConfig.param2) then
			logError(string.format("CommonSkinInteraction _onPlayVoice param2:%s is error, voiceConfig: %s", slot0._voiceConfig.param2, tostring(slot0._voiceConfig.audio)))

			return
		end

		slot0._startTime = Time.time
		slot0._protectionTime = lua_character_special_interaction_voice.configDict[slot1].protectionTime or 0
		slot0._waitTime = slot2.time
		slot0._waitVoice = slot2.waitVoice
		slot0._timeoutVoiceConfig = lua_character_voice.configDict[slot0._voiceConfig.heroId][slot2.timeoutVoice]

		CharacterVoiceController.instance:trackSpecialInteraction(slot0._voiceConfig.heroId, slot0._voiceConfig.audio, CharacterVoiceController.instance:getSpecialInteractionPlayType())
	end
end

function slot0._waitTimeout(slot0)
	slot0._isSpecialInteraction = nil

	slot0:playVoice(slot0._timeoutVoiceConfig)
end

function slot0._onStopVoice(slot0)
	slot0._isSpecialInteraction = nil
	slot0._waitVoice = nil
	slot0._timeoutVoiceConfig = nil

	TaskDispatcher.cancelTask(slot0._waitTimeout, slot0)
end

function slot0.needRespond(slot0)
	return slot0._isSpecialInteraction
end

function slot0.canPlay(slot0, slot1)
	if slot0._isSpecialInteraction then
		if Time.time - slot0._startTime <= slot0._protectionTime then
			return false
		end

		return slot1.audio == slot0._waitVoice
	end

	if slot0._voiceConfig and slot0._isRespondType then
		return false
	end

	return true
end

function slot0._onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._waitTimeout, slot0)
end

return slot0
