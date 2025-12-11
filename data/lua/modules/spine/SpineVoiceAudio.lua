module("modules.spine.SpineVoiceAudio", package.seeall)

local var_0_0 = class("SpineVoiceAudio")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0._spineVoice = nil
	arg_2_0._voiceConfig = nil
	arg_2_0._spine = nil
	arg_2_0._addAudios = nil
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._spineVoice = arg_3_1
	arg_3_0._voiceConfig = arg_3_2
	arg_3_0._spine = arg_3_3
	arg_3_0._hasAudio = AudioConfig.instance:getAudioCOById(arg_3_2.audio)

	if arg_3_0._hasAudio then
		arg_3_0._emitter = ZProj.AudioEmitter.Get(arg_3_3:getSpineGo())

		if not arg_3_0._emitter then
			arg_3_0:_onVoiceEnd()

			return
		end

		if arg_3_4 then
			local var_3_0 = GameConfig:GetCurVoiceShortcut()
			local var_3_1 = AudioConfig.instance:getAudioCOById(arg_3_2.audio)
			local var_3_2 = var_3_1.eventName
			local var_3_3 = var_3_1.bankName

			if SettingsModel.instance:isZhRegion() == false then
				if string.nilorempty(var_3_1.eventName_Overseas) == false then
					var_3_2 = var_3_1.eventName_Overseas
				end

				if string.nilorempty(var_3_1.bankName_Overseas) == false then
					var_3_3 = var_3_1.bankName_Overseas
				end
			end

			arg_3_0._emitter:EmitterByName(var_3_3, var_3_2, arg_3_4, arg_3_0._onEmitterCallback, arg_3_0)
		else
			arg_3_0._emitter:Emitter(arg_3_2.audio, arg_3_0._onEmitterCallback, arg_3_0)
		end

		print("playVoice:", arg_3_2.audio)
		AudioMgr.instance:addAudioLog(arg_3_2.audio, "yellow", "播放音效开始")
	else
		print("playVoice no audio:", arg_3_2.audio)
		arg_3_0:_onVoiceEnd()
	end

	arg_3_0._hasAddAudio = arg_3_2.addaudio and arg_3_2.addaudio ~= ""

	if arg_3_0._hasAddAudio then
		arg_3_0._addAudios = {}

		local var_3_4 = GameLanguageMgr.instance:getVoiceTypeStoryIndex()

		if arg_3_4 then
			var_3_4 = GameLanguageMgr.instance:getStoryIndexByShortCut(arg_3_4)
		end

		local var_3_5 = string.split(arg_3_2.addaudio, "|")

		for iter_3_0, iter_3_1 in pairs(var_3_5) do
			local var_3_6 = string.splitToNumber(iter_3_1, "#")
			local var_3_7 = var_3_6[1]
			local var_3_8 = var_3_6[var_3_4 + 1]
			local var_3_9 = SpineVoiceAddAudio.New()

			var_3_9:init(var_3_7, var_3_8 or 0)
			table.insert(arg_3_0._addAudios, var_3_9)
		end
	end
end

function var_0_0.hasAudio(arg_4_0)
	return arg_4_0._hasAudio
end

function var_0_0.setSwitch(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0._emitter then
		arg_5_0._emitter = ZProj.AudioEmitter.Get(arg_5_1:getSpineGo())
	end

	if arg_5_0._emitter then
		arg_5_0._emitter:SetSwitch(arg_5_2, arg_5_3)
	end
end

function var_0_0._onEmitterCallback(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif arg_6_1 == AudioEnum.AkCallbackType.AK_EndOfEvent then
		arg_6_0:_emitterStopVoice()
	end
end

function var_0_0._emitterStopVoice(arg_7_0)
	arg_7_0:_onVoiceEnd()
end

function var_0_0._onVoiceEnd(arg_8_0)
	if not arg_8_0._spineVoice then
		return
	end

	if arg_8_0._hasAudio then
		arg_8_0._spineVoice:onSpineVoiceAudioStop()
	end

	arg_8_0._spineVoice:_onComponentStop(arg_8_0)

	if arg_8_0._hasAudio then
		AudioMgr.instance:addAudioLog(arg_8_0._voiceConfig.audio, "green", "播放音效结束")
	end
end

function var_0_0.getEmitter(arg_9_0)
	if arg_9_0._spine then
		if arg_9_0._emitter == nil or gohelper.isNil(arg_9_0._emitter) then
			arg_9_0._emitter = ZProj.AudioEmitter.Get(arg_9_0._spine:getSpineGo())
		end

		return arg_9_0._emitter
	else
		return nil
	end
end

function var_0_0.onVoiceStop(arg_10_0)
	if arg_10_0._addAudios then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._addAudios) do
			iter_10_1:onDestroy()
		end

		arg_10_0._addAudios = nil
	end
end

return var_0_0
