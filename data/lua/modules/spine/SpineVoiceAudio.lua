module("modules.spine.SpineVoiceAudio", package.seeall)

slot0 = class("SpineVoiceAudio")

function slot0.ctor(slot0)
end

function slot0.onDestroy(slot0)
	slot0._spineVoice = nil
	slot0._voiceConfig = nil
	slot0._spine = nil
	slot0._addAudios = nil
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0._spineVoice = slot1
	slot0._voiceConfig = slot2
	slot0._spine = slot3
	slot0._hasAudio = AudioConfig.instance:getAudioCOById(slot2.audio)

	if slot0._hasAudio then
		slot0._emitter = ZProj.AudioEmitter.Get(slot3:getSpineGo())

		if not slot0._emitter then
			slot0:_onVoiceEnd()

			return
		end

		if slot4 then
			slot5 = GameConfig:GetCurVoiceShortcut()
			slot6 = AudioConfig.instance:getAudioCOById(slot2.audio)
			slot7 = slot6.eventName
			slot8 = slot6.bankName

			if SettingsModel.instance:isZhRegion() == false then
				if string.nilorempty(slot6.eventName_Overseas) == false then
					slot7 = slot6.eventName_Overseas
				end

				if string.nilorempty(slot6.bankName_Overseas) == false then
					slot8 = slot6.bankName_Overseas
				end
			end

			slot0._emitter:EmitterByName(slot8, slot7, slot4, slot0._onEmitterCallback, slot0)
		else
			slot0._emitter:Emitter(slot2.audio, slot0._onEmitterCallback, slot0)
		end

		print("playVoice:", slot2.audio)
		AudioMgr.instance:addAudioLog(slot2.audio, "yellow", "播放音效开始")
	else
		print("playVoice no audio:", slot2.audio)
		slot0:_onVoiceEnd()
	end

	slot0._hasAddAudio = slot2.addaudio and slot2.addaudio ~= ""

	if slot0._hasAddAudio then
		slot0._addAudios = {}
		slot5 = GameLanguageMgr.instance:getVoiceTypeStoryIndex()

		if slot4 then
			slot5 = GameLanguageMgr.instance:getStoryIndexByShortCut(slot4)
		end

		for slot10, slot11 in pairs(string.split(slot2.addaudio, "|")) do
			slot12 = string.splitToNumber(slot11, "#")
			slot15 = SpineVoiceAddAudio.New()

			slot15:init(slot12[1], slot12[slot5 + 1])
			table.insert(slot0._addAudios, slot15)
		end
	end
end

function slot0.hasAudio(slot0)
	return slot0._hasAudio
end

function slot0.setSwitch(slot0, slot1, slot2, slot3)
	if not slot0._emitter then
		slot0._emitter = ZProj.AudioEmitter.Get(slot1:getSpineGo())
	end

	if slot0._emitter then
		slot0._emitter:SetSwitch(slot2, slot3)
	end
end

function slot0._onEmitterCallback(slot0, slot1, slot2)
	if slot1 == AudioEnum.AkCallbackType.AK_Duration then
		-- Nothing
	elseif slot1 == AudioEnum.AkCallbackType.AK_EndOfEvent then
		slot0:_emitterStopVoice()
	end
end

function slot0._emitterStopVoice(slot0)
	slot0:_onVoiceEnd()
end

function slot0._onVoiceEnd(slot0)
	if not slot0._spineVoice then
		return
	end

	if slot0._hasAudio then
		slot0._spineVoice:onSpineVoiceAudioStop()
	end

	slot0._spineVoice:_onComponentStop(slot0)

	if slot0._hasAudio then
		AudioMgr.instance:addAudioLog(slot0._voiceConfig.audio, "green", "播放音效结束")
	end
end

function slot0.getEmitter(slot0)
	if slot0._spine then
		if slot0._emitter == nil or gohelper.isNil(slot0._emitter) then
			slot0._emitter = ZProj.AudioEmitter.Get(slot0._spine:getSpineGo())
		end

		return slot0._emitter
	else
		return nil
	end
end

function slot0.onVoiceStop(slot0)
	if slot0._addAudios then
		for slot4, slot5 in pairs(slot0._addAudios) do
			slot5:onDestroy()
		end

		slot0._addAudios = nil
	end
end

return slot0
