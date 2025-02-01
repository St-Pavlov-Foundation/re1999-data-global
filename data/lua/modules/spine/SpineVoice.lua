module("modules.spine.SpineVoice", package.seeall)

slot0 = class("SpineVoice")

function slot0.ctor(slot0)
	slot0._componentStopVoiceCount = 0
	slot0._spineVoiceText = slot0:_addComponent(SpineVoiceText)
	slot0._spineVoiceBody = slot0:_addComponent(SpineVoiceBody, true)
	slot0._spineVoiceAudio = slot0:_addComponent(SpineVoiceAudio, true)

	slot0:_init()
end

function slot0._init(slot0)
	slot0._spineVoiceMouth = slot0:_addComponent(SpineVoiceMouth, true)
	slot0._voiceFace = slot0:_addComponent(SpineVoiceFace, true)
end

function slot0._addComponent(slot0, slot1, slot2)
	if slot2 then
		slot0._componentStopVoiceCount = slot0._componentStopVoiceCount + 1
	end

	return slot1.New()
end

function slot0.stopVoice(slot0)
	slot0._manualStopVoice = true

	if not slot0._playVoice then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	slot0:_onVoiceStop()
end

function slot0.setDiffFaceBiYan(slot0, slot1)
	slot0._voiceFace:setDiffFaceBiYan(slot1)
end

function slot0.setInStory(slot0)
	slot0._isInStory = true
end

function slot0.getInStory(slot0)
	return slot0._isInStory
end

function slot0.getVoiceLang(slot0)
	return slot0._lang
end

function slot0.getPlayVoiceStartTime(slot0)
	return slot0._playVoiceStartTime
end

function slot0.playVoice(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot2 and slot2.audio then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	end

	slot0._playVoiceStartTime = Time.time
	slot0._playVoice = true
	slot0._manualStopVoice = false
	slot0._stopVoiceCount = 0
	slot0._callback = slot3
	slot0._spine = slot1
	slot0._voiceConfig = slot2
	slot0._txtContent = slot4
	slot0._txtEnContent = slot5
	slot0._bgGo = slot6
	slot0._showBg = slot7

	slot0:setBgVisible(true)
	slot0._spine:stopTransition()

	if slot2.heroId then
		slot9, slot10, slot11 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot8)
		slot13 = GameConfig:GetCurVoiceShortcut()

		if not string.nilorempty(LangSettings.shortcutTab[slot9]) and not slot11 then
			slot0._spineVoiceAudio:init(slot0, slot2, slot1, slot12)
		else
			slot0._spineVoiceAudio:init(slot0, slot2, slot1)
		end
	else
		slot0._spineVoiceAudio:init(slot0, slot2, slot1)
	end

	if slot0._spineVoiceAudio:hasAudio() then
		slot0._lang = AudioMgr.instance:getLangByAudioId(slot2.audio)
	else
		slot0._lang = AudioMgr.instance:getCurLang()
	end

	if slot4 or slot5 then
		slot0._spineVoiceText:init(slot0, slot2, slot4, slot5, slot7)
	end

	slot0:_initSpineVoiceMouth(slot2, slot1)
	slot0._voiceFace:init(slot0, slot2, slot1)
	slot0._spineVoiceBody:init(slot0, slot2, slot1)
end

function slot0._initSpineVoiceMouth(slot0, slot1, slot2)
	slot0._spineVoiceMouth:init(slot0, slot1, slot2)
end

function slot0.setSwitch(slot0, slot1, slot2, slot3)
	slot0._spineVoiceAudio:setSwitch(slot1, slot2, slot3)
end

function slot0.playing(slot0)
	return slot0._playVoice
end

function slot0.onSpineVoiceAudioStop(slot0)
	slot0._spineVoiceText:onVoiceStop()
	slot0:_doCallback()
end

function slot0._onComponentStop(slot0, slot1)
	slot0._stopVoiceCount = slot0._stopVoiceCount + 1

	if slot0._componentStopVoiceCount <= slot0._stopVoiceCount then
		slot0:_onVoiceStop()
	end
end

function slot0.forceNoMouth(slot0)
	slot0._spineVoiceMouth:forceNoMouth()
end

function slot0._onVoiceStop(slot0)
	if not slot0._playVoice then
		return
	end

	slot0._playVoice = false

	slot0._spineVoiceAudio:onVoiceStop()
	slot0._spineVoiceMouth:onVoiceStop()
	slot0._spineVoiceText:onVoiceStop()
	slot0._voiceFace:onVoiceStop()
	slot0._spineVoiceBody:onVoiceStop()
	slot0:_doCallback()
end

function slot0._doCallback(slot0)
	slot0._callback = nil

	if slot0._callback then
		slot1()
	end
end

function slot0.setBgVisible(slot0, slot1)
	gohelper.setActive(slot0._bgGo, slot1)
end

function slot0.onAnimationEvent(slot0, slot1, slot2, slot3)
	if slot2 ~= SpineAnimEvent.ActionComplete then
		return
	end

	if slot0._manualStopVoice then
		return
	end

	if slot0._voiceFace:checkFaceEnd(slot1) then
		return
	end

	if slot0._spineVoiceBody:checkBodyEnd(slot1) then
		return
	end

	if slot0._spineVoiceMouth:checkMouthEnd(slot1) then
		return
	end
end

function slot0.onDestroy(slot0)
	if slot0._spineVoiceText then
		slot0._spineVoiceText:onDestroy()

		slot0._spineVoiceText = nil
	end

	if slot0._spineVoiceMouth then
		slot0._spineVoiceMouth:onDestroy()

		slot0._spineVoiceMouth = nil
	end

	if slot0._voiceFace then
		slot0._voiceFace:onDestroy()

		slot0._voiceFace = nil
	end

	if slot0._spineVoiceBody then
		slot0._spineVoiceBody:onDestroy()

		slot0._spineVoiceBody = nil
	end

	if slot0._spineVoiceAudio then
		slot0._spineVoiceAudio:onDestroy()

		slot0._spineVoiceAudio = nil
	end

	slot0._spine = nil
end

return slot0
