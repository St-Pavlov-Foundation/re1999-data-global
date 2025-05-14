module("modules.audio.PlayHeroVoice", package.seeall)

local var_0_0 = class("PlayHeroVoice")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 and arg_2_1.audio then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	end

	arg_2_0._voiceConfig = arg_2_1
	arg_2_0._txtContent = arg_2_2
	arg_2_0._txtEnContent = arg_2_3
	arg_2_0._goContentBg = arg_2_4
	arg_2_0._hasAudio = AudioConfig.instance:getAudioCOById(arg_2_1.audio)
	arg_2_0._showEnContent = LangSettings.instance:langCaptionsActive()

	if arg_2_0._txtContent then
		arg_2_0._contentStart = Time.time
		arg_2_0._contentList = {}

		arg_2_0:_initContent(arg_2_0._contentList, arg_2_0:getContent(arg_2_1))
	end

	if arg_2_0._txtEnContent then
		arg_2_0._enContentStart = Time.time
		arg_2_0._enContentList = {}

		arg_2_0:_initContent(arg_2_0._enContentList, arg_2_0:getContent(arg_2_1, LanguageEnum.LanguageStoryType.EN))
		gohelper.setActive(arg_2_0._txtEnContent.gameObject, arg_2_0._showEnContent)
	end

	arg_2_0:playVoice()
	TaskDispatcher.runRepeat(arg_2_0._showContent, arg_2_0, 0.1)
end

function var_0_0._showContent(arg_3_0)
	arg_3_0:_showOneLang(arg_3_0._contentList, arg_3_0._contentStart, arg_3_0._txtContent)

	if arg_3_0._showEnContent then
		arg_3_0:_showOneLang(arg_3_0._enContentList, arg_3_0._enContentStart, arg_3_0._txtEnContent)
	end

	arg_3_0:_checkTxtEnd()
end

function var_0_0._showOneLang(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 then
		local var_4_0 = arg_4_1[1]

		if not var_4_0 then
			return
		end

		local var_4_1 = var_4_0[2] or 0

		if var_4_0 and not var_4_0[2] then
			logError("没有配置时间 audio:" .. arg_4_0._voiceConfig.audio)
		end

		if var_4_1 <= Time.time - arg_4_2 then
			arg_4_3.text = var_4_0[1]

			table.remove(arg_4_1, 1)
		end
	end
end

function var_0_0._checkTxtEnd(arg_5_0)
	if arg_5_0._hasAudio then
		return
	end

	if arg_5_0:_contentListEmpty() and arg_5_0._voiceConfig.displayTime > 0 then
		TaskDispatcher.cancelTask(arg_5_0._showContent, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._onTxtEnd, arg_5_0, arg_5_0._voiceConfig.displayTime)
	end
end

function var_0_0._onTxtEnd(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onTxtEnd, arg_6_0)
	arg_6_0:onVoiceTxtStop()
end

function var_0_0.getContent(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2 or GameLanguageMgr.instance:getLanguageTypeStoryIndex()
	local var_7_1 = GameConfig:GetCurVoiceShortcut()
	local var_7_2 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_7_1)

	return (SpineVoiceTextHelper.getSeparateContent(arg_7_1, var_7_0, var_7_2))
end

function var_0_0.getVoiceLang(arg_8_0, arg_8_1)
	if arg_8_0._hasAudio then
		arg_8_0._lang = AudioMgr.instance:getLangByAudioId(arg_8_1.audio)
	else
		arg_8_0._lang = AudioMgr.instance:getCurLang()
	end

	return arg_8_0._lang
end

function var_0_0.contentListIsEmpty(arg_9_0)
	return (not arg_9_0._contentList or #arg_9_0._contentList == 0) and (not arg_9_0._enContentList or #arg_9_0._enContentList == 0)
end

function var_0_0._initContent(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = string.split(arg_10_2, "|")

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1 ~= "" then
			local var_10_1 = string.split(iter_10_1, "#")

			var_10_1[2] = tonumber(var_10_1[2])

			table.insert(arg_10_1, var_10_1)
		end
	end
end

function var_0_0.removeTaskActions(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showContent, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onTxtEnd, arg_11_0)
end

function var_0_0.onVoiceTxtStop(arg_12_0)
	arg_12_0:removeTaskActions()

	if not gohelper.isNil(arg_12_0._txtContent) then
		arg_12_0._txtContent.text = ""
	end

	if not gohelper.isNil(arg_12_0._txtEnContent) then
		arg_12_0._txtEnContent.text = ""
	end
end

function var_0_0.playVoice(arg_13_0)
	if arg_13_0._hasAudio then
		arg_13_0._emitter = ZProj.AudioEmitter.Get(arg_13_0._goContentBg)

		if not arg_13_0._emitter then
			arg_13_0:_onVoiceEnd()

			return
		end

		arg_13_0._emitter:Emitter(arg_13_0._voiceConfig.audio, arg_13_0._onEmitterCallback, arg_13_0)
	else
		arg_13_0:_onVoiceEnd()
	end
end

function var_0_0._onEmitterCallback(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif arg_14_1 == AudioEnum.AkCallbackType.AK_EndOfEvent then
		arg_14_0:_onVoiceEnd()
	end
end

function var_0_0._onVoiceEnd(arg_15_0)
	arg_15_0:onVoiceTxtStop()
end

function var_0_0.dispose(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	arg_16_0:_onVoiceEnd()

	arg_16_0._emitter = nil
end

return var_0_0
