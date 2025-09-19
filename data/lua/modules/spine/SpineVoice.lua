module("modules.spine.SpineVoice", package.seeall)

local var_0_0 = class("SpineVoice")

function var_0_0.ctor(arg_1_0)
	arg_1_0._componentStopVoiceCount = 0
	arg_1_0._spineVoiceText = arg_1_0:_addComponent(SpineVoiceText)
	arg_1_0._spineVoiceBody = arg_1_0:_addComponent(SpineVoiceBody, true)
	arg_1_0._spineVoiceAudio = arg_1_0:_addComponent(SpineVoiceAudio, true)

	arg_1_0:_init()
end

function var_0_0._init(arg_2_0)
	arg_2_0._spineVoiceMouth = arg_2_0:_addComponent(SpineVoiceMouth, true)
	arg_2_0._voiceFace = arg_2_0:_addComponent(SpineVoiceFace, true)
end

function var_0_0._addComponent(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		arg_3_0._componentStopVoiceCount = arg_3_0._componentStopVoiceCount + 1
	end

	return arg_3_1.New()
end

function var_0_0.stopVoice(arg_4_0)
	arg_4_0._manualStopVoice = true

	if not arg_4_0._playVoice then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	arg_4_0:_onVoiceStop()
end

function var_0_0.setDiffFaceBiYan(arg_5_0, arg_5_1)
	arg_5_0._voiceFace:setDiffFaceBiYan(arg_5_1)
end

function var_0_0.setInStory(arg_6_0)
	arg_6_0._isInStory = true
end

function var_0_0.getInStory(arg_7_0)
	return arg_7_0._isInStory
end

function var_0_0.getVoiceLang(arg_8_0)
	return arg_8_0._lang
end

function var_0_0.getPlayVoiceStartTime(arg_9_0)
	return arg_9_0._playVoiceStartTime
end

function var_0_0.playVoice(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	if arg_10_2 and arg_10_2.audio then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	end

	arg_10_0._playVoiceStartTime = Time.time
	arg_10_0._playVoice = true
	arg_10_0._manualStopVoice = false
	arg_10_0._stopVoiceCount = 0
	arg_10_0._callback = arg_10_3
	arg_10_0._spine = arg_10_1
	arg_10_0._voiceConfig = arg_10_2
	arg_10_0._txtContent = arg_10_4
	arg_10_0._txtEnContent = arg_10_5
	arg_10_0._bgGo = arg_10_6
	arg_10_0._showBg = arg_10_7

	arg_10_0:setBgVisible(true)
	arg_10_0._spine:stopTransition()

	local var_10_0 = arg_10_2.heroId

	if var_10_0 then
		local var_10_1, var_10_2, var_10_3 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_10_0)
		local var_10_4 = LangSettings.shortcutTab[var_10_1]
		local var_10_5 = GameConfig:GetCurVoiceShortcut()

		if not string.nilorempty(var_10_4) and not var_10_3 then
			arg_10_0._spineVoiceAudio:init(arg_10_0, arg_10_2, arg_10_1, var_10_4)
		else
			arg_10_0._spineVoiceAudio:init(arg_10_0, arg_10_2, arg_10_1)
		end
	else
		arg_10_0._spineVoiceAudio:init(arg_10_0, arg_10_2, arg_10_1)
	end

	if arg_10_0._spineVoiceAudio:hasAudio() then
		arg_10_0._lang = AudioMgr.instance:getLangByAudioId(arg_10_2.audio)
	else
		arg_10_0._lang = AudioMgr.instance:getCurLang()
	end

	if arg_10_4 or arg_10_5 then
		arg_10_0._spineVoiceText:init(arg_10_0, arg_10_2, arg_10_4, arg_10_5, arg_10_7)
	end

	arg_10_0:_initSpineVoiceMouth(arg_10_2, arg_10_1)
	arg_10_0._voiceFace:init(arg_10_0, arg_10_2, arg_10_1)

	if arg_10_2.noChangeBody ~= true or not arg_10_0._spineVoiceBody:getSpineVoice() then
		arg_10_0._spineVoiceBody:init(arg_10_0, arg_10_2, arg_10_1)
	end
end

function var_0_0._initSpineVoiceMouth(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._spineVoiceMouth:init(arg_11_0, arg_11_1, arg_11_2)
end

function var_0_0.setSwitch(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._spineVoiceAudio:setSwitch(arg_12_1, arg_12_2, arg_12_3)
end

function var_0_0.playing(arg_13_0)
	return arg_13_0._playVoice
end

function var_0_0.onSpineVoiceAudioStop(arg_14_0)
	arg_14_0._spineVoiceText:onVoiceStop()
	arg_14_0:_doCallback()
end

function var_0_0._onComponentStop(arg_15_0, arg_15_1)
	arg_15_0._stopVoiceCount = arg_15_0._stopVoiceCount + 1

	if arg_15_0._stopVoiceCount >= arg_15_0._componentStopVoiceCount then
		arg_15_0:_onVoiceStop()
	end
end

function var_0_0.forceNoMouth(arg_16_0)
	arg_16_0._spineVoiceMouth:forceNoMouth()
end

function var_0_0._onVoiceStop(arg_17_0)
	if not arg_17_0._playVoice then
		return
	end

	arg_17_0._playVoice = false

	arg_17_0._spineVoiceAudio:onVoiceStop()
	arg_17_0._spineVoiceMouth:onVoiceStop()
	arg_17_0._spineVoiceText:onVoiceStop()
	arg_17_0._voiceFace:onVoiceStop()
	arg_17_0._spineVoiceBody:onVoiceStop()
	arg_17_0:_doCallback()
end

function var_0_0._doCallback(arg_18_0)
	local var_18_0 = arg_18_0._callback

	arg_18_0._callback = nil

	if var_18_0 then
		var_18_0()
	end
end

function var_0_0.setBgVisible(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._bgGo, arg_19_1)
end

function var_0_0.onAnimationEvent(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 ~= SpineAnimEvent.ActionComplete then
		return
	end

	if arg_20_0._manualStopVoice then
		return
	end

	if arg_20_0._voiceFace:checkFaceEnd(arg_20_1) then
		return
	end

	if arg_20_0._spineVoiceBody:checkBodyEnd(arg_20_1) then
		return
	end

	if arg_20_0._spineVoiceMouth:checkMouthEnd(arg_20_1) then
		return
	end
end

function var_0_0.onDestroy(arg_21_0)
	if arg_21_0._spineVoiceText then
		arg_21_0._spineVoiceText:onDestroy()

		arg_21_0._spineVoiceText = nil
	end

	if arg_21_0._spineVoiceMouth then
		arg_21_0._spineVoiceMouth:onDestroy()

		arg_21_0._spineVoiceMouth = nil
	end

	if arg_21_0._voiceFace then
		arg_21_0._voiceFace:onDestroy()

		arg_21_0._voiceFace = nil
	end

	if arg_21_0._spineVoiceBody then
		arg_21_0._spineVoiceBody:onDestroy()

		arg_21_0._spineVoiceBody = nil
	end

	if arg_21_0._spineVoiceAudio then
		arg_21_0._spineVoiceAudio:onDestroy()

		arg_21_0._spineVoiceAudio = nil
	end

	arg_21_0._spine = nil
end

return var_0_0
