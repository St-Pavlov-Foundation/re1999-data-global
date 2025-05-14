module("modules.logic.main.view.skininteraction.CommonSkinInteraction", package.seeall)

local var_0_0 = class("CommonSkinInteraction", BaseSkinInteraction)

function var_0_0._onClick(arg_1_0, arg_1_1)
	arg_1_0:_clickDefault(arg_1_1)
end

function var_0_0._isSpecialRespondType(arg_2_0, arg_2_1)
	return arg_2_1 == CharacterEnum.VoiceType.MainViewSpecialRespond or arg_2_1 == CharacterEnum.VoiceType.MainViewDragSpecialRespond
end

function var_0_0._beforePlayVoice(arg_3_0, arg_3_1)
	arg_3_0._isRespondType = arg_3_0._isSpecialInteraction and arg_3_0:_isSpecialRespondType(arg_3_1.type)
	arg_3_0._changeValue = nil

	local var_3_0 = arg_3_1 and arg_3_1.audio == arg_3_0._waitVoice

	if var_3_0 then
		arg_3_0._changeValue = CharacterVoiceController.instance:getChangeValue(arg_3_1)
	end

	if arg_3_0:_isSpecialRespondType(arg_3_1.type) then
		CharacterVoiceController.instance:trackSpecialInteraction(arg_3_1.heroId, arg_3_1.audio, var_3_0 and CharacterVoiceEnum.PlayType.Click or CharacterVoiceEnum.PlayType.Auto)
	end
end

function var_0_0._afterPlayVoice(arg_4_0, arg_4_1)
	if arg_4_0._changeValue then
		PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, arg_4_1.heroId, arg_4_0._changeValue)

		local var_4_0 = PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.SkinState)

		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.SkinState, var_4_0)
	end
end

function var_0_0._onPlayVoiceFinish(arg_5_0, arg_5_1)
	if arg_5_0._isDragging then
		return
	end

	if arg_5_0._isSpecialInteraction then
		TaskDispatcher.runDelay(arg_5_0._waitTimeout, arg_5_0, arg_5_0._waitTime)
	end

	arg_5_0._voiceConfig = nil
end

function var_0_0.beginDrag(arg_6_0)
	arg_6_0._isDragging = true

	TaskDispatcher.cancelTask(arg_6_0._waitTimeout, arg_6_0)
end

function var_0_0.endDrag(arg_7_0)
	arg_7_0._isDragging = false

	if arg_7_0._isSpecialInteraction then
		TaskDispatcher.runDelay(arg_7_0._waitTimeout, arg_7_0, arg_7_0._waitTime)
	end
end

function var_0_0._onPlayVoice(arg_8_0)
	arg_8_0:_onStopVoice()

	arg_8_0._isSpecialInteraction = arg_8_0._voiceConfig.type == CharacterEnum.VoiceType.MainViewSpecialInteraction

	if arg_8_0._isSpecialInteraction then
		local var_8_0 = tonumber(arg_8_0._voiceConfig.param2)

		if not var_8_0 then
			logError(string.format("CommonSkinInteraction _onPlayVoice param2:%s is error, voiceConfig: %s", arg_8_0._voiceConfig.param2, tostring(arg_8_0._voiceConfig.audio)))

			return
		end

		local var_8_1 = lua_character_special_interaction_voice.configDict[var_8_0]

		arg_8_0._startTime = Time.time
		arg_8_0._protectionTime = var_8_1.protectionTime or 0
		arg_8_0._waitTime = var_8_1.time
		arg_8_0._waitVoice = var_8_1.waitVoice
		arg_8_0._timeoutVoiceConfig = lua_character_voice.configDict[arg_8_0._voiceConfig.heroId][var_8_1.timeoutVoice]

		CharacterVoiceController.instance:trackSpecialInteraction(arg_8_0._voiceConfig.heroId, arg_8_0._voiceConfig.audio, CharacterVoiceController.instance:getSpecialInteractionPlayType())
	end
end

function var_0_0._waitTimeout(arg_9_0)
	arg_9_0._isSpecialInteraction = nil

	arg_9_0:playVoice(arg_9_0._timeoutVoiceConfig)
end

function var_0_0._onStopVoice(arg_10_0)
	arg_10_0._isSpecialInteraction = nil
	arg_10_0._waitVoice = nil
	arg_10_0._timeoutVoiceConfig = nil

	TaskDispatcher.cancelTask(arg_10_0._waitTimeout, arg_10_0)
end

function var_0_0.needRespond(arg_11_0)
	return arg_11_0._isSpecialInteraction
end

function var_0_0.canPlay(arg_12_0, arg_12_1)
	if arg_12_0._isSpecialInteraction then
		if Time.time - arg_12_0._startTime <= arg_12_0._protectionTime then
			return false
		end

		return arg_12_1.audio == arg_12_0._waitVoice
	end

	if arg_12_0._voiceConfig and arg_12_0._isRespondType then
		return false
	end

	return true
end

function var_0_0._onDestroy(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._waitTimeout, arg_13_0)
end

return var_0_0
