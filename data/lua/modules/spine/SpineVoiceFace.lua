module("modules.spine.SpineVoiceFace", package.seeall)

slot0 = class("SpineVoiceFace")
slot1 = "_biyan"

function slot0.ctor(slot0)
end

function slot0.onDestroy(slot0)
	slot0:removeTaskActions()
	TaskDispatcher.cancelTask(slot0._stopTransition, slot0)

	slot0._spineVoice = nil
	slot0._voiceConfig = nil
	slot0._spine = nil
end

function slot0.setFaceAnimation(slot0, slot1, slot2)
	if string.find(slot1, uv0) then
		slot2 = false
	end

	slot0._loop = slot2

	TaskDispatcher.cancelTask(slot0._nonLoopFaceEnd, slot0)

	slot0._lastFaceName = slot1

	slot0:_doSetFaceAnimation(slot1, slot2)
end

function slot0._doSetFaceAnimation(slot0, slot1, slot2)
	if slot1 ~= slot0._spine:getCurFace() then
		slot3 = slot0._mixTime or 0.5

		if string.find(slot1, uv0) then
			slot3 = 0.3
		end

		slot0._spine:setFaceAnimation(slot1, slot2, slot3)
	end
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._spineVoice = slot1
	slot0._voiceConfig = slot2
	slot0._spine = slot3

	slot0:playFaceActionList(slot0:getFace(slot2))
end

function slot0.getFace(slot0, slot1)
	if slot0._spineVoice:getVoiceLang() == "zh" then
		return slot1.face
	else
		return slot1[slot2 .. "face"] or slot1.face
	end
end

function slot0._configValidity(slot0, slot1, slot2)
	for slot6 = #slot1, 1, -1 do
		slot9 = true

		if #string.split(slot1[slot6], "#") >= 3 and slot2:hasAnimation("e_" .. slot8[1]) then
			slot9 = false
		end

		if slot9 then
			logError(string.format("id：%s 语音 face 无效的配置：%s face:%s", slot0._voiceConfig.audio, slot7, slot0:getFace(slot0._voiceConfig)))
			table.remove(slot1, slot6)
		end
	end
end

function slot0.playFaceActionList(slot0, slot1)
	slot0._faceStart = 0

	if not string.nilorempty(slot1) then
		slot0._faceList = string.split(slot1, "|")

		slot0:_configValidity(slot0._faceList, slot0._spine)
	else
		slot0._faceList = {}
	end

	slot0:_playFaceAction(slot0._diffFaceBiYan)
end

function slot0._playFaceAction(slot0, slot1)
	slot0._faceActionName = nil
	slot2 = true

	slot0:removeTaskActions()

	slot3 = true

	if #slot0._faceList > 0 and #string.split(table.remove(slot0._faceList, 1), "#") >= 3 then
		slot0._faceActionName = "e_" .. slot5[1]
		slot0._faceActionDuration = tonumber(slot5[3]) - tonumber(slot5[2])
		slot0._mixTime = tonumber(slot5[4])
		slot0._setLoop = slot5[5] == nil
		slot0._delayTime = slot6 - slot0._faceStart
		slot0._faceStart = slot7
		slot0._faceActionStartTime = Time.time

		if slot0._delayTime > 0 then
			TaskDispatcher.runDelay(slot0._faceActionDelay, slot0, slot0._delayTime)
		else
			slot2 = false

			slot0:_faceActionDelay()
		end

		slot3 = false
	end

	if slot2 then
		slot0:setNormal()

		if slot1 then
			slot0:setBiYan(slot0:_needBiYan(StoryAnimName.E_ZhengChang))
		end
	end

	if slot3 then
		slot0:_onFaceEnd()
	end
end

function slot0._onFaceEnd(slot0)
	slot0._spineVoice:_onComponentStop(slot0)
end

function slot0.setNormal(slot0)
	slot0:setFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

function slot0._faceActionDelay(slot0)
	slot0:setFaceAnimation(slot0._faceActionName, slot0._setLoop)

	if not string.find(slot0._faceActionName, uv0) then
		slot0:setBiYan(slot0:_needBiYan(slot0._faceActionName))
	end
end

function slot0.setBiYan(slot0, slot1)
	if not slot0._spine then
		return
	end

	if slot1 then
		slot0._spine:setTransition(StoryAnimName.H_BiYan, false, 0)
	elseif slot1 == false then
		slot0._spine:setTransition(StoryAnimName.H_ZhengYan, false, 0)
	end

	TaskDispatcher.cancelTask(slot0._stopTransition, slot0)
	TaskDispatcher.runDelay(slot0._stopTransition, slot0, 1)
end

function slot0._stopTransition(slot0)
	slot0._spine:stopTransition()
end

function slot0._needBiYan(slot0, slot1)
	slot2 = slot0._diffFaceBiYan and slot0._lastFaceName or slot0._spine:getCurFace()

	if slot2 and not string.find(slot2, uv0) and slot0._diffFaceBiYan then
		slot3 = slot1 ~= slot0._lastFaceName and true or nil
	end

	return slot3
end

function slot0.setDiffFaceBiYan(slot0, slot1)
	slot0._diffFaceBiYan = slot1
end

function slot0.checkFaceEnd(slot0, slot1)
	if slot1 == slot0._faceActionName then
		if slot0._faceActionStartTime + slot0._faceActionDuration + slot0._delayTime <= Time.time then
			slot0:_playFaceAction(true)

			return true
		end

		if not slot0._loop then
			TaskDispatcher.runDelay(slot0._nonLoopFaceEnd, slot0, slot2 - slot3)
		end

		return true
	end
end

function slot0._nonLoopFaceEnd(slot0)
	slot0:_playFaceAction(true)
end

function slot0.removeTaskActions(slot0)
	TaskDispatcher.cancelTask(slot0._faceActionDelay, slot0)
	TaskDispatcher.cancelTask(slot0._nonLoopFaceEnd, slot0)
end

function slot0.onVoiceStop(slot0)
	slot0:removeTaskActions()
	slot0:_doSetFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

return slot0
