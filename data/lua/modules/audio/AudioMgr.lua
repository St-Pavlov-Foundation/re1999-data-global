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

function var_0_0._onInitCS(arg_3_0, arg_3_1)
	local var_3_0 = GameConfig:GetCurVoiceShortcut()

	logNormal("AudioMgr:init, voiceType = " .. var_3_0)
	arg_3_0:changeLang(var_3_0)

	if arg_3_0._onInited then
		local var_3_1 = arg_3_0._onInited
		local var_3_2 = arg_3_0._onInitedObj

		arg_3_0._onInited = nil
		arg_3_0._onInitedObj = nil

		if var_3_2 then
			var_3_1(var_3_2, arg_3_1)
		else
			var_3_1(arg_3_1)
		end
	end
end

function var_0_0.initSoundVolume(arg_4_0)
	local var_4_0 = SettingsModel.instance:getMusicValue()
	local var_4_1 = SettingsModel.instance:getVoiceValue()
	local var_4_2 = SettingsModel.instance:getEffectValue()
	local var_4_3 = SettingsModel.instance:getGlobalAudioVolume()

	arg_4_0:setRTPCValue(AudioEnum.Volume.Music_Volume, var_4_0)
	arg_4_0:setRTPCValue(AudioEnum.Volume.Voc_Volume, var_4_1)
	arg_4_0:setRTPCValue(AudioEnum.Volume.SFX_Volume, var_4_2)
	arg_4_0:setRTPCValue(AudioEnum.Volume.Global_Volume, var_4_3)

	if var_4_1 > 0 then
		arg_4_0:setState(arg_4_0:getIdFromString("Voc_Volume_M"), arg_4_0:getIdFromString("no"))
	else
		arg_4_0:setState(arg_4_0:getIdFromString("Voc_Volume_M"), arg_4_0:getIdFromString("yes"))
	end
end

function var_0_0.changeEarMode(arg_5_0)
	local var_5_0 = SDKMgr.instance:isEarphoneContact()

	logNormal("isEarConnect : " .. tostring(var_5_0))
	arg_5_0:setRTPCValue(AudioEnum.EarRTPC, var_5_0 and 0 or 1)
end

function var_0_0.trigger(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = AudioConfig.instance:getAudioCOById(arg_6_1)

	if var_6_0 == nil then
		logError("AudioManager.TriggerAudio, audio cfg is null for audioId = " .. arg_6_1)

		return
	end

	local var_6_1 = var_6_0.eventName
	local var_6_2 = var_6_0.bankName

	if SettingsModel.instance:isZhRegion() == false then
		if string.nilorempty(var_6_0.eventName_Overseas) == false then
			var_6_1 = var_6_0.eventName_Overseas
		end

		if string.nilorempty(var_6_0.bankName_Overseas) == false then
			var_6_2 = var_6_0.bankName_Overseas
		end
	end

	local var_6_3 = arg_6_0.csharpInst:TriggerEvent(var_6_1, var_6_2, arg_6_2)

	arg_6_0:dispatchEvent(var_0_0.Evt_Trigger, arg_6_1)

	return var_6_3
end

function var_0_0.triggerEx(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.csharpInst:TriggerAudioEx(arg_7_1, arg_7_2, arg_7_3)

	arg_7_0:dispatchEvent(var_0_0.Evt_Trigger, arg_7_1)

	return var_7_0
end

function var_0_0.getSourcePlayPosition(arg_8_0, arg_8_1)
	return arg_8_0.csharpInst:GetSourcePlayPosition(arg_8_1)
end

function var_0_0.getLangByAudioId(arg_9_0, arg_9_1)
	return arg_9_0.csharpInst:GetLangByAudioId(arg_9_1)
end

function var_0_0.setSwitch(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.csharpInst:SetSwitch(arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:addNormalLog("#00BBFF", "触发Switch : " .. tostring(arg_10_1) .. ", " .. tostring(arg_10_2))
end

function var_0_0.setState(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.csharpInst:SetState(arg_11_1, arg_11_2)
end

function var_0_0.getSwitch(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0.csharpInst:GetSwitch(arg_12_1, arg_12_2)
end

function var_0_0.getIdFromString(arg_13_0, arg_13_1)
	arg_13_0._idCache = arg_13_0._idCache or {}

	local var_13_0 = arg_13_0._idCache[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0.csharpInst:GetIDFromString(arg_13_1)
		arg_13_0._idCache[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.setRTPCValue(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.csharpInst then
		return
	end

	arg_14_0.csharpInst:SetRTPCValue(arg_14_1, arg_14_2)
end

function var_0_0.setRTPCValueByPlayingID(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	if not arg_15_0.csharpInst then
		return
	end

	if arg_15_4 then
		arg_15_0.csharpInst:SetRTPCValueByPlayingID(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	else
		arg_15_0.csharpInst:SetRTPCValueByPlayingID(arg_15_1, arg_15_2, arg_15_3)
	end
end

function var_0_0.setGameObjectOutputBusVolume(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.csharpInst:SetGameObjectOutputBusVolume(arg_16_1, arg_16_2)
end

function var_0_0.stopPlayingID(arg_17_0, arg_17_1)
	arg_17_0.csharpInst:StopPlayingID(arg_17_1)
end

function var_0_0.getRTPCValue(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return arg_18_0.csharpInst:GetRTPCValue(arg_18_1, arg_18_2, arg_18_3)
end

function var_0_0.changeLang(arg_19_0, arg_19_1)
	arg_19_0.csharpInst:SwitchLanguage(arg_19_1, arg_19_0._onChangeFinish, arg_19_0)
end

function var_0_0._onChangeFinish(arg_20_0)
	logNormal("_onChangeFinish ----------------->!")
	arg_20_0:changeEarMode()
	arg_20_0:dispatchEvent(var_0_0.Evt_ChangeFinish)
end

function var_0_0.getCurLang(arg_21_0)
	return arg_21_0.csharpInst:GetCurLang()
end

function var_0_0.clearUnusedBanks(arg_22_0)
	arg_22_0.csharpInst:UnloadUnusedBanks()
end

function var_0_0.addAudioLog(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_1 and var_0_0.GMOpenLog then
		local var_23_0 = AudioConfig.instance:getAudioCOById(arg_23_1)
		local var_23_1 = var_23_0 and var_23_0.eventName or "event=nil"

		logNormal(string.format("<color=%s>GMAudioLog %s：%d %s</color>\n%s", arg_23_2, arg_23_3, arg_23_1, var_23_1, debug.traceback()))
	end
end

function var_0_0.addNormalLog(arg_24_0, arg_24_1, arg_24_2)
	if var_0_0.GMOpenLog then
		logNormal(string.format("<color=%s>GMAudioLog %s</color>\n%s", arg_24_1, arg_24_2, debug.traceback()))
	end
end

function var_0_0.useDefaultBGM(arg_25_0)
	return VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
