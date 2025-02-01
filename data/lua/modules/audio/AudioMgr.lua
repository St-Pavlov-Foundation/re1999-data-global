module("modules.audio.AudioMgr", package.seeall)

slot0 = class("AudioMgr")
slot0.GMOpenLog = nil
slot0.Evt_ChangeFinish = 1
slot0.Evt_Trigger = 2

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1, slot2)
	ActivityHelper.activateClass("AudioEnum%d_%d", 1, 5)

	slot0._onInited = slot1
	slot0._onInitedObj = slot2
	slot0.csharpInst = ZProj.AudioManager.Instance

	AudioConfig.instance:InitCSByConfig(slot0.csharpInst)
	slot0.csharpInst:InitFromLua(slot0._onInitCS, slot0)

	slot0.csharpInst.autoSwitchToDefault = false
end

function slot0._onInitCS(slot0, slot1)
	slot2 = GameConfig:GetCurVoiceShortcut()

	logNormal("AudioMgr:init, voiceType = " .. slot2)
	slot0:changeLang(slot2)

	if slot0._onInited then
		slot0._onInited = nil
		slot0._onInitedObj = nil

		if slot0._onInitedObj then
			slot0._onInited(slot4, slot1)
		else
			slot3(slot1)
		end
	end
end

function slot0.initSoundVolume(slot0)
	slot2 = SettingsModel.instance:getVoiceValue()

	slot0:setRTPCValue(AudioEnum.Volume.Music_Volume, SettingsModel.instance:getMusicValue())
	slot0:setRTPCValue(AudioEnum.Volume.Voc_Volume, slot2)
	slot0:setRTPCValue(AudioEnum.Volume.SFX_Volume, SettingsModel.instance:getEffectValue())
	slot0:setRTPCValue(AudioEnum.Volume.Global_Volume, SettingsModel.instance:getGlobalAudioVolume())

	if slot2 > 0 then
		slot0:setState(slot0:getIdFromString("Voc_Volume_M"), slot0:getIdFromString("no"))
	else
		slot0:setState(slot0:getIdFromString("Voc_Volume_M"), slot0:getIdFromString("yes"))
	end
end

function slot0.changeEarMode(slot0)
	slot1 = SDKMgr.instance:isEarphoneContact()

	logNormal("isEarConnect : " .. tostring(slot1))
	slot0:setRTPCValue(AudioEnum.EarRTPC, slot1 and 0 or 1)
end

function slot0.trigger(slot0, slot1, slot2)
	if AudioConfig.instance:getAudioCOById(slot1) == nil then
		logError("AudioManager.TriggerAudio, audio cfg is null for audioId = " .. slot1)

		return
	end

	slot4 = slot3.eventName
	slot5 = slot3.bankName

	if SettingsModel.instance:isZhRegion() == false then
		if string.nilorempty(slot3.eventName_Overseas) == false then
			slot4 = slot3.eventName_Overseas
		end

		if string.nilorempty(slot3.bankName_Overseas) == false then
			slot5 = slot3.bankName_Overseas
		end
	end

	slot0:dispatchEvent(uv0.Evt_Trigger, slot1)

	return slot0.csharpInst:TriggerEvent(slot4, slot5, slot2)
end

function slot0.triggerEx(slot0, slot1, slot2, slot3)
	slot0:dispatchEvent(uv0.Evt_Trigger, slot1)

	return slot0.csharpInst:TriggerAudioEx(slot1, slot2, slot3)
end

function slot0.getSourcePlayPosition(slot0, slot1)
	return slot0.csharpInst:GetSourcePlayPosition(slot1)
end

function slot0.getLangByAudioId(slot0, slot1)
	return slot0.csharpInst:GetLangByAudioId(slot1)
end

function slot0.setSwitch(slot0, slot1, slot2, slot3)
	slot0.csharpInst:SetSwitch(slot1, slot2, slot3)
	slot0:addNormalLog("#00BBFF", "触发Switch : " .. tostring(slot1) .. ", " .. tostring(slot2))
end

function slot0.setState(slot0, slot1, slot2)
	slot0.csharpInst:SetState(slot1, slot2)
end

function slot0.getSwitch(slot0, slot1, slot2)
	return slot0.csharpInst:GetSwitch(slot1, slot2)
end

function slot0.getIdFromString(slot0, slot1)
	slot0._idCache = slot0._idCache or {}

	if not slot0._idCache[slot1] then
		slot0._idCache[slot1] = slot0.csharpInst:GetIDFromString(slot1)
	end

	return slot2
end

function slot0.setRTPCValue(slot0, slot1, slot2)
	if not slot0.csharpInst then
		return
	end

	slot0.csharpInst:SetRTPCValue(slot1, slot2)
end

function slot0.setRTPCValueByPlayingID(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0.csharpInst then
		return
	end

	if slot4 then
		slot0.csharpInst:SetRTPCValueByPlayingID(slot1, slot2, slot3, slot4, slot5, slot6)
	else
		slot0.csharpInst:SetRTPCValueByPlayingID(slot1, slot2, slot3)
	end
end

function slot0.setGameObjectOutputBusVolume(slot0, slot1, slot2)
	slot0.csharpInst:SetGameObjectOutputBusVolume(slot1, slot2)
end

function slot0.stopPlayingID(slot0, slot1)
	slot0.csharpInst:StopPlayingID(slot1)
end

function slot0.getRTPCValue(slot0, slot1, slot2, slot3)
	return slot0.csharpInst:GetRTPCValue(slot1, slot2, slot3)
end

function slot0.changeLang(slot0, slot1)
	slot0.csharpInst:SwitchLanguage(slot1, slot0._onChangeFinish, slot0)
end

function slot0._onChangeFinish(slot0)
	logNormal("_onChangeFinish ----------------->!")
	slot0:changeEarMode()
	slot0:dispatchEvent(uv0.Evt_ChangeFinish)
end

function slot0.getCurLang(slot0)
	return slot0.csharpInst:GetCurLang()
end

function slot0.clearUnusedBanks(slot0)
	slot0.csharpInst:UnloadUnusedBanks()
end

function slot0.addAudioLog(slot0, slot1, slot2, slot3)
	if slot1 and uv0.GMOpenLog then
		logNormal(string.format("<color=%s>GMAudioLog %s：%d %s</color>\n%s", slot2, slot3, slot1, AudioConfig.instance:getAudioCOById(slot1) and slot4.eventName or "event=nil", debug.traceback()))
	end
end

function slot0.addNormalLog(slot0, slot1, slot2)
	if uv0.GMOpenLog then
		logNormal(string.format("<color=%s>GMAudioLog %s</color>\n%s", slot1, slot2, debug.traceback()))
	end
end

function slot0.useDefaultBGM(slot0)
	return VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
