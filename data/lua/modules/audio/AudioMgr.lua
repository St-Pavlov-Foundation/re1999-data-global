module("modules.audio.AudioMgr", package.seeall)

local var_0_0 = class("AudioMgr")

var_0_0.GMOpenLog = nil
var_0_0.Evt_ChangeFinish = 1
var_0_0.Evt_Trigger = 2

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	AudioEnum1_5.activate()
	AudioEnum1_6.activate()
	AudioEnum1_7.activate()
	AudioEnum1_8.activate()
	AudioEnum1_9.activate()
	AudioEnum2_0.activate()
	AudioEnum2_1.activate()
	AudioEnum2_2.activate()
	AudioEnum2_3.activate()
	AudioEnum2_4.activate()
	AudioEnum2_5.activate()

	arg_2_0._onInited = arg_2_1
	arg_2_0._onInitedObj = arg_2_2
	arg_2_0.csharpInst = ZProj.AudioManager.Instance

	AudioConfig.instance:InitCSByConfig(arg_2_0.csharpInst)
	arg_2_0.csharpInst:InitFromLua(arg_2_0._onInitCS, arg_2_0)

	arg_2_0.csharpInst.autoSwitchToDefault = false
end

function var_0_0._setAutoSwitchDefault(arg_3_0, arg_3_1)
	arg_3_0.csharpInst.autoSwitchToDefault = arg_3_1 == LangSettings.shortcutTab[LangSettings.jp] or arg_3_1 == LangSettings.shortcutTab[LangSettings.kr]
end

function var_0_0._onInitCS(arg_4_0, arg_4_1)
	local var_4_0 = GameConfig:GetCurVoiceShortcut()

	logNormal("AudioMgr:init, voiceType = " .. var_4_0)
	arg_4_0:changeLang(var_4_0)

	if arg_4_0._onInited then
		local var_4_1 = arg_4_0._onInited
		local var_4_2 = arg_4_0._onInitedObj

		arg_4_0._onInited = nil
		arg_4_0._onInitedObj = nil

		if var_4_2 then
			var_4_1(var_4_2, arg_4_1)
		else
			var_4_1(arg_4_1)
		end
	end
end

function var_0_0.initSoundVolume(arg_5_0)
	local var_5_0 = SettingsModel.instance:getMusicValue()
	local var_5_1 = SettingsModel.instance:getVoiceValue()
	local var_5_2 = SettingsModel.instance:getEffectValue()
	local var_5_3 = SettingsModel.instance:getGlobalAudioVolume()

	arg_5_0:setRTPCValue(AudioEnum.Volume.Music_Volume, var_5_0)
	arg_5_0:setRTPCValue(AudioEnum.Volume.Voc_Volume, var_5_1)
	arg_5_0:setRTPCValue(AudioEnum.Volume.SFX_Volume, var_5_2)
	arg_5_0:setRTPCValue(AudioEnum.Volume.Global_Volume, var_5_3)

	if var_5_1 > 0 then
		arg_5_0:setState(arg_5_0:getIdFromString("Voc_Volume_M"), arg_5_0:getIdFromString("no"))
	else
		arg_5_0:setState(arg_5_0:getIdFromString("Voc_Volume_M"), arg_5_0:getIdFromString("yes"))
	end
end

function var_0_0.changeEarMode(arg_6_0)
	local var_6_0 = SDKMgr.instance:isEarphoneContact()

	logNormal("isEarConnect : " .. tostring(var_6_0))
	arg_6_0:setRTPCValue(AudioEnum.EarRTPC, var_6_0 and 0 or 1)
end

function var_0_0.trigger(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = AudioConfig.instance:getAudioCOById(arg_7_1)

	if var_7_0 == nil then
		logError("AudioManager.TriggerAudio, audio cfg is null for audioId = " .. tostring(arg_7_1))

		return
	end

	local var_7_1 = var_7_0.eventName
	local var_7_2 = var_7_0.bankName

	if SettingsModel.instance:isZhRegion() == false then
		if string.nilorempty(var_7_0.eventName_Overseas) == false then
			var_7_1 = var_7_0.eventName_Overseas
		end

		if string.nilorempty(var_7_0.bankName_Overseas) == false then
			var_7_2 = var_7_0.bankName_Overseas
		end
	end

	local var_7_3 = arg_7_0.csharpInst:TriggerEvent(var_7_1, var_7_2, arg_7_2)

	arg_7_0:dispatchEvent(var_0_0.Evt_Trigger, arg_7_1)

	return var_7_3
end

function var_0_0.triggerEx(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0.csharpInst:TriggerAudioEx(arg_8_1, arg_8_2, arg_8_3)

	arg_8_0:dispatchEvent(var_0_0.Evt_Trigger, arg_8_1)

	return var_8_0
end

function var_0_0.getSourcePlayPosition(arg_9_0, arg_9_1)
	return arg_9_0.csharpInst:GetSourcePlayPosition(arg_9_1)
end

function var_0_0.getLangByAudioId(arg_10_0, arg_10_1)
	return arg_10_0.csharpInst:GetLangByAudioId(arg_10_1)
end

function var_0_0.setSwitch(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.csharpInst:SetSwitch(arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:addNormalLog("#00BBFF", "触发Switch : " .. tostring(arg_11_1) .. ", " .. tostring(arg_11_2))
end

function var_0_0.setState(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.csharpInst:SetState(arg_12_1, arg_12_2)
end

function var_0_0.getSwitch(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0.csharpInst:GetSwitch(arg_13_1, arg_13_2)
end

function var_0_0.getIdFromString(arg_14_0, arg_14_1)
	arg_14_0._idCache = arg_14_0._idCache or {}

	local var_14_0 = arg_14_0._idCache[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0.csharpInst:GetIDFromString(arg_14_1)
		arg_14_0._idCache[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.setRTPCValue(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0.csharpInst then
		return
	end

	arg_15_0.csharpInst:SetRTPCValue(arg_15_1, arg_15_2)
end

function var_0_0.setRTPCValueByPlayingID(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	if not arg_16_0.csharpInst then
		return
	end

	if arg_16_4 then
		arg_16_0.csharpInst:SetRTPCValueByPlayingID(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	else
		arg_16_0.csharpInst:SetRTPCValueByPlayingID(arg_16_1, arg_16_2, arg_16_3)
	end
end

function var_0_0.setGameObjectOutputBusVolume(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.csharpInst:SetGameObjectOutputBusVolume(arg_17_1, arg_17_2)
end

function var_0_0.stopPlayingID(arg_18_0, arg_18_1)
	arg_18_0.csharpInst:StopPlayingID(arg_18_1)
end

function var_0_0.getRTPCValue(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	return arg_19_0.csharpInst:GetRTPCValue(arg_19_1, arg_19_2, arg_19_3)
end

function var_0_0.changeLang(arg_20_0, arg_20_1)
	arg_20_0:_setAutoSwitchDefault(arg_20_1)
	arg_20_0.csharpInst:UnloadUnusedBanks()
	arg_20_0.csharpInst:SwitchLanguage(arg_20_1, arg_20_0._onChangeFinish, arg_20_0)
end

function var_0_0._onChangeFinish(arg_21_0)
	logNormal("_onChangeFinish ----------------->!")
	arg_21_0:changeEarMode()
	arg_21_0:dispatchEvent(var_0_0.Evt_ChangeFinish)
end

function var_0_0.getCurLang(arg_22_0)
	return arg_22_0.csharpInst:GetCurLang()
end

function var_0_0.clearUnusedBanks(arg_23_0)
	arg_23_0.csharpInst:UnloadUnusedBanks()
end

function var_0_0.addAudioLog(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_1 and var_0_0.GMOpenLog then
		local var_24_0 = AudioConfig.instance:getAudioCOById(arg_24_1)
		local var_24_1 = var_24_0 and var_24_0.eventName or "event=nil"

		logNormal(string.format("<color=%s>GMAudioLog %s：%d %s</color>\n%s", arg_24_2, arg_24_3, arg_24_1, var_24_1, debug.traceback()))
	end
end

function var_0_0.addNormalLog(arg_25_0, arg_25_1, arg_25_2)
	if var_0_0.GMOpenLog then
		logNormal(string.format("<color=%s>GMAudioLog %s</color>\n%s", arg_25_1, arg_25_2, debug.traceback()))
	end
end

function var_0_0.useDefaultBGM(arg_26_0)
	return VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
