module("modules.live2d.Live2dVoice", package.seeall)

slot0 = class("Live2dVoice", SpineVoice)

function slot0._init(slot0)
	slot0._normalVoiceMouth = slot0:_addComponent(Live2dVoiceMouth, true)
	slot0._spineVoiceMouth = slot0._normalVoiceMouth
	slot0._voiceFace = slot0:_addComponent(Live2dVoiceFace, true)
end

function slot0.getMouth(slot0, slot1)
	if slot0:getVoiceLang() == "zh" then
		return slot1.mouth
	else
		return slot1[slot2 .. "mouth"] or slot1.mouth
	end
end

function slot0._initSpineVoiceMouth(slot0, slot1, slot2)
	slot0._useAutoMouth = string.find(slot0:getMouth(slot1), Live2dVoiceMouthAuto.AutoActionName)
	slot4 = slot0._spineVoiceMouth

	if slot0._useAutoMouth then
		slot0._autoVoiceMouth = slot0._autoVoiceMouth or Live2dVoiceMouthAuto.New()
		slot0._spineVoiceMouth = slot0._autoVoiceMouth
	else
		slot0._spineVoiceMouth = slot0._normalVoiceMouth
	end

	if slot4 and slot4 ~= slot0._spineVoiceMouth then
		slot4:suspend()
	end

	slot0._spineVoiceMouth:init(slot0, slot1, slot2)
end

function slot0.onSpineVoiceAudioStop(slot0)
	slot0._spineVoiceText:onVoiceStop()

	if slot0._useAutoMouth then
		slot0._spineVoiceMouth:onVoiceStop()
	end

	slot0:_doCallback()
end

function slot0.playVoice(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._spine = slot1

	slot1:setParameterStoreEnabled(true)

	if slot0:getInStory() then
		slot0._spine:setAlwaysFade(true)
	end

	uv0.super.playVoice(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0._onComponentStop(slot0, slot1)
	if slot1 == slot0._spineVoiceBody and slot0._spine and slot0:getInStory() then
		slot0._spine:setAlwaysFade(false)
	end

	uv0.super._onComponentStop(slot0, slot1)
end

function slot0.playing(slot0)
	if slot0._spineVoiceMouth._setComponentStop then
		return uv0.super.playing(slot0)
	end

	if slot0._useAutoMouth then
		return slot0._stopVoiceCount < slot0._componentStopVoiceCount - 1
	end

	return slot0._stopVoiceCount < slot0._componentStopVoiceCount - 1 or not slot0._spineVoiceMouth._playLastOne
end

function slot0.onDestroy(slot0)
	if slot0._normalVoiceMouth then
		slot0._normalVoiceMouth:onDestroy()

		slot0._normalVoiceMouth = nil
	end

	if slot0._autoVoiceMouth then
		slot0._autoVoiceMouth:onDestroy()

		slot0._autoVoiceMouth = nil
	end

	slot0._spineVoiceMouth = nil

	uv0.super.onDestroy(slot0)
end

return slot0
