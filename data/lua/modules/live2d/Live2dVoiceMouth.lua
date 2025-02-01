module("modules.live2d.Live2dVoiceMouth", package.seeall)

slot0 = class("Live2dVoiceMouth", SpineVoiceMouth)

function slot0.removeTaskActions(slot0)
	uv0.super.removeTaskActions(slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayMouthActionList, slot0)
end

function slot0._checkPlayMouthActionList(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._delayPlayMouthActionList, slot0)

	slot0._mouthConfig = slot1

	if slot0._stopTime and Time.time - slot0._stopTime < 0.1 then
		TaskDispatcher.runDelay(slot0._delayPlayMouthActionList, slot0, 0.1 - (Time.time - slot0._stopTime))

		return
	end

	slot0:_playMouthActionList(slot1)
end

function slot0._delayPlayMouthActionList(slot0)
	slot0:_playMouthActionList(slot0._mouthConfig)
end

function slot0.stopMouthCallback(slot0, slot1)
	slot0:stopMouth()
end

function slot0._setBiZui(slot0)
	if slot0._isVoiceStop and slot0._pauseMouth and slot0._pauseMouth ~= slot0._spine:getCurMouth() then
		slot0._curMouth = "t_" .. slot0._pauseMouth
		slot0._pauseMouth = nil

		slot0._spine:setMouthAnimation(slot0._curMouth, false, 0)

		return
	end

	if slot0._spine:hasAnimation(StoryAnimName.T_BiZui) then
		slot0._curMouth = StoryAnimName.T_BiZui

		slot0._spine:setMouthAnimation(slot0._curMouth, true, 0)
	else
		logError("no animation:t_bizui")
	end
end

function slot0.onVoiceStop(slot0)
	slot0._isVoiceStop = true
	slot0._stopTime = Time.time

	slot0:stopMouth()
	slot0:removeTaskActions()

	slot0._isVoiceStop = false
end

function slot0.suspend(slot0)
	slot0:removeTaskActions()
end

return slot0
