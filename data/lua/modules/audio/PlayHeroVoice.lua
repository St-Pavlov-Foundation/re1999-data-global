module("modules.audio.PlayHeroVoice", package.seeall)

slot0 = class("PlayHeroVoice")

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	if slot1 and slot1.audio then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	end

	slot0._voiceConfig = slot1
	slot0._txtContent = slot2
	slot0._txtEnContent = slot3
	slot0._goContentBg = slot4
	slot0._hasAudio = AudioConfig.instance:getAudioCOById(slot1.audio)
	slot0._showEnContent = LangSettings.instance:langCaptionsActive()

	if slot0._txtContent then
		slot0._contentStart = Time.time
		slot0._contentList = {}

		slot0:_initContent(slot0._contentList, slot0:getContent(slot1))
	end

	if slot0._txtEnContent then
		slot0._enContentStart = Time.time
		slot0._enContentList = {}

		slot0:_initContent(slot0._enContentList, slot0:getContent(slot1, LanguageEnum.LanguageStoryType.EN))
		gohelper.setActive(slot0._txtEnContent.gameObject, slot0._showEnContent)
	end

	slot0:playVoice()
	TaskDispatcher.runRepeat(slot0._showContent, slot0, 0.1)
end

function slot0._showContent(slot0)
	slot0:_showOneLang(slot0._contentList, slot0._contentStart, slot0._txtContent)

	if slot0._showEnContent then
		slot0:_showOneLang(slot0._enContentList, slot0._enContentStart, slot0._txtEnContent)
	end

	slot0:_checkTxtEnd()
end

function slot0._showOneLang(slot0, slot1, slot2, slot3)
	if slot1 then
		if not slot1[1] then
			return
		end

		slot5 = slot4[2] or 0

		if slot4 and not slot4[2] then
			logError("没有配置时间 audio:" .. slot0._voiceConfig.audio)
		end

		if slot5 <= Time.time - slot2 then
			slot3.text = slot4[1]

			table.remove(slot1, 1)
		end
	end
end

function slot0._checkTxtEnd(slot0)
	if slot0._hasAudio then
		return
	end

	if slot0:_contentListEmpty() and slot0._voiceConfig.displayTime > 0 then
		TaskDispatcher.cancelTask(slot0._showContent, slot0)
		TaskDispatcher.runDelay(slot0._onTxtEnd, slot0, slot0._voiceConfig.displayTime)
	end
end

function slot0._onTxtEnd(slot0)
	TaskDispatcher.cancelTask(slot0._onTxtEnd, slot0)
	slot0:onVoiceTxtStop()
end

function slot0.getContent(slot0, slot1, slot2)
	return SpineVoiceTextHelper.getSeparateContent(slot1, slot2 or GameLanguageMgr.instance:getLanguageTypeStoryIndex(), GameLanguageMgr.instance:getStoryIndexByShortCut(GameConfig:GetCurVoiceShortcut()))
end

function slot0.getVoiceLang(slot0, slot1)
	if slot0._hasAudio then
		slot0._lang = AudioMgr.instance:getLangByAudioId(slot1.audio)
	else
		slot0._lang = AudioMgr.instance:getCurLang()
	end

	return slot0._lang
end

function slot0.contentListIsEmpty(slot0)
	return (not slot0._contentList or #slot0._contentList == 0) and (not slot0._enContentList or #slot0._enContentList == 0)
end

function slot0._initContent(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(string.split(slot2, "|")) do
		if slot8 ~= "" then
			slot9 = string.split(slot8, "#")
			slot9[2] = tonumber(slot9[2])

			table.insert(slot1, slot9)
		end
	end
end

function slot0.removeTaskActions(slot0)
	TaskDispatcher.cancelTask(slot0._showContent, slot0)
	TaskDispatcher.cancelTask(slot0._onTxtEnd, slot0)
end

function slot0.onVoiceTxtStop(slot0)
	slot0:removeTaskActions()

	if not gohelper.isNil(slot0._txtContent) then
		slot0._txtContent.text = ""
	end

	if not gohelper.isNil(slot0._txtEnContent) then
		slot0._txtEnContent.text = ""
	end
end

function slot0.playVoice(slot0)
	if slot0._hasAudio then
		slot0._emitter = ZProj.AudioEmitter.Get(slot0._goContentBg)

		if not slot0._emitter then
			slot0:_onVoiceEnd()

			return
		end

		slot0._emitter:Emitter(slot0._voiceConfig.audio, slot0._onEmitterCallback, slot0)
	else
		slot0:_onVoiceEnd()
	end
end

function slot0._onEmitterCallback(slot0, slot1, slot2)
	if slot1 == AudioEnum.AkCallbackType.AK_Duration then
		-- Nothing
	elseif slot1 == AudioEnum.AkCallbackType.AK_EndOfEvent then
		slot0:_onVoiceEnd()
	end
end

function slot0._onVoiceEnd(slot0)
	slot0:onVoiceTxtStop()
end

function slot0.dispose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	slot0:_onVoiceEnd()

	slot0._emitter = nil
end

return slot0
