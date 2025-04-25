module("modules.spine.SpineVoiceBody", package.seeall)

slot0 = class("SpineVoiceBody")

function slot0.ctor(slot0)
end

function slot0.onDestroy(slot0)
	slot0:removeTaskActions()

	slot0._spineVoice = nil
	slot0._voiceConfig = nil
	slot0._spine = nil
end

function slot0.setBodyAnimation(slot0, slot1, slot2, slot3)
	slot4 = slot0._spine:getCurBody()

	if slot0:_getPlayMotionMixTime(slot1) then
		slot3 = slot5
	end

	slot0:_setBodyAnimation(slot1, slot2, slot3, slot0._motionCutList[slot4])
end

function slot0._getPlayMotionMixTime(slot0, slot1)
	if not slot0._motionPlayCutList[slot1] then
		return
	end

	if slot0._motionPlayCutConfig.whenStopped == 1 and slot0._isVoiceStopping then
		return 0
	end

	if slot0._motionPlayCutConfig.whenNotStopped == 1 and not slot0._isVoiceStopping then
		return 0
	end
end

function slot0._setBodyAnimation(slot0, slot1, slot2, slot3, slot4)
	if slot4 then
		if not slot0._onlyVoiceStopCut then
			slot3 = 0
		end

		if slot0._onlyVoiceStopCut and slot0._isVoiceStopping then
			slot3 = 0
		end
	end

	if slot1 ~= slot0._spine:getCurBody() then
		slot0._spine:setBodyAnimation(slot1, slot2, slot3 or 0.2)
	end
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._spineVoice = slot1
	slot0._voiceConfig = slot2
	slot0._spine = slot3
	slot0._skinId = slot3 and slot3._skinId

	slot0:_initCutMotion(slot2)
	slot0:_initPlayCutMotion(slot2)

	slot0._onlyVoiceStopCut = slot0._motionCutConfig and slot0._motionCutConfig.onlyStopCut == 1

	slot0:playBodyActionList(slot0:getMotion(slot2))
end

function slot0.getMotion(slot0, slot1)
	if slot0._spineVoice:getVoiceLang() == "zh" then
		return slot1.motion
	else
		return slot1[slot2 .. "motion"] or slot1.motion
	end
end

function slot0._getHeroId(slot0, slot1)
	if slot1.storyHeroIndex then
		return lua_story_hero_to_character.configDict[slot1.storyHeroIndex] and slot2.heroId
	end

	return slot1.heroId
end

function slot0._initCutMotion(slot0, slot1)
	slot0._motionCutList = {}
	slot0._motionCutConfig = nil

	if not lua_character_motion_cut.configDict[slot0:_getHeroId(slot1)] then
		return
	end

	if not (slot0._skinId and slot2[slot0._skinId] or slot2[1]) then
		return
	end

	slot0._motionCutConfig = slot2

	for slot8, slot9 in ipairs(string.split(slot2.motion, "|")) do
		slot0._motionCutList["b_" .. slot9] = true
	end
end

function slot0._initPlayCutMotion(slot0, slot1)
	slot0._motionPlayCutList = {}
	slot0._motionPlayCutConfig = nil

	if not lua_character_motion_play_cut.configDict[slot0:_getHeroId(slot1)] then
		return
	end

	if not (slot0._skinId and slot2[slot0._skinId] or slot2[1]) then
		return
	end

	slot0._motionPlayCutConfig = slot2

	for slot8, slot9 in ipairs(string.split(slot2.motion, "|")) do
		slot0._motionPlayCutList["b_" .. slot9] = true
	end
end

function slot0._configValidity(slot0, slot1, slot2)
	for slot6 = #slot1, 1, -1 do
		slot9 = true

		if string.split(slot1[slot6], "#")[2] and slot2:hasAnimation("b_" .. slot8[1]) then
			slot9 = false
		end

		if slot9 then
			if SLFramework.FrameworkSettings.IsEditor then
				logWarn(string.format("编辑器下的调试log，无需在意。 id：%s 语音 body 无效的配置：%s motion:%s", slot0._voiceConfig.audio, slot7, slot0._motion))
			end

			table.remove(slot1, slot6)
		end
	end
end

function slot0.playBodyActionList(slot0, slot1)
	slot0._bodyStart = 0
	slot0._motion = slot1

	if not string.nilorempty(slot1) then
		slot0._bodyList = string.split(slot1, "|")

		slot0:_configValidity(slot0._bodyList, slot0._spine)
	else
		slot0._bodyList = {}
	end

	slot0._appointIdleName = nil
	slot0._appointIdleMixTime = nil

	slot0:_playBodyAction()
end

function slot0._checkAppointIdle(slot0)
	if slot0._spineVoice:getInStory() and #slot0._bodyList > 0 and string.split(slot0._bodyList[1], "#")[3] == "-2" then
		slot0._appointIdleName = "b_" .. slot2[1]
		slot0._appointIdleMixTime = tonumber(slot2[4])

		table.remove(slot0._bodyList, 1)
	end
end

function slot0._playBodyAction(slot0)
	slot0._bodyActionName = nil
	slot0._playBodyName = nil
	slot0._nextActionStartTime = nil
	slot1 = true
	slot2 = true

	slot0:_checkAppointIdle()
	TaskDispatcher.cancelTask(slot0._bodyActionDelay, slot0)

	if #slot0._bodyList > 0 and string.split(table.remove(slot0._bodyList, 1), "#")[2] then
		slot0._bodyActionName = "b_" .. slot4[1]
		slot0._actionLoop = slot4[3] == "-1"
		slot0._mixTime = slot4[4] and tonumber(slot4[4])
		slot0._bodyStartTime = Time.time

		if tonumber(slot4[2]) - slot0._bodyStart > 0 then
			TaskDispatcher.runDelay(slot0._bodyActionDelay, slot0, slot6)
		else
			slot1 = false

			if slot0._onlyVoiceStopCut then
				TaskDispatcher.runDelay(slot0._bodyActionDelay, slot0, 0)
			else
				slot0:_bodyActionDelay()
			end
		end

		slot2 = false
	end

	if slot1 then
		slot0:setNormal()
	end

	slot0:_startCheckLoopEnd()

	if slot2 then
		slot0:_onBodyEnd()
	end
end

function slot0._startCheckLoopEnd(slot0)
	slot0._nextActionStartTime = nil

	TaskDispatcher.cancelTask(slot0._checkLoopActionEnd, slot0)

	if not slot0._actionLoop then
		return
	end

	if #slot0._bodyList > 0 and string.split(slot0._bodyList[1], "#")[2] then
		slot0._nextActionStartTime = slot0._bodyStartTime + tonumber(slot2[2]) - slot0._bodyStart
	end

	if slot0._nextActionStartTime then
		TaskDispatcher.runRepeat(slot0._checkLoopActionEnd, slot0, 0)
	end
end

function slot0._checkLoopActionEnd(slot0)
	if not slot0._nextActionStartTime then
		TaskDispatcher.cancelTask(slot0._checkLoopActionEnd, slot0)

		return
	end

	if slot0._nextActionStartTime <= Time.time then
		TaskDispatcher.cancelTask(slot0._checkLoopActionEnd, slot0)

		slot0._bodyStart = slot0._bodyStart + Time.time - slot0._bodyStartTime

		slot0:_playBodyAction()
	end
end

function slot0._onBodyEnd(slot0)
	slot0._spineVoice:_onComponentStop(slot0)
end

function slot0.setNormal(slot0)
	if slot0._appointIdleName then
		slot0:setBodyAnimation(slot0._appointIdleName, true, slot0._appointIdleMixTime)

		slot0._appointIdleMixTime = nil

		return
	end

	slot0:setBodyAnimation(slot0._spineVoice:getInStory() and StoryAnimName.B_IDLE or CharacterVoiceController.instance:getIdle(slot0._voiceConfig.heroId), true)
end

function slot0._bodyActionDelay(slot0)
	if slot0._lastBodyActionName and slot0._motionCutList[slot0._lastBodyActionName] then
		slot0:_setBodyAnimation(slot0._bodyActionName, slot0._actionLoop, slot0._mixTime, true)
	else
		slot0:setBodyAnimation(slot0._bodyActionName, slot0._actionLoop, slot0._mixTime)
	end

	slot0._lastBodyActionName = slot0._bodyActionName
	slot0._playBodyName = slot0._bodyActionName
end

function slot0.checkBodyEnd(slot0, slot1)
	if slot1 == slot0._playBodyName and not slot0._actionLoop then
		slot0._bodyStart = slot0._bodyStart + Time.time - slot0._bodyStartTime

		slot0:_playBodyAction()

		return true
	end
end

function slot0.removeTaskActions(slot0)
	TaskDispatcher.cancelTask(slot0._bodyActionDelay, slot0)
	TaskDispatcher.cancelTask(slot0._checkLoopActionEnd, slot0)
end

function slot0.onVoiceStop(slot0)
	slot0._isVoiceStopping = true

	slot0:removeTaskActions()
	slot0:setNormal()

	slot0._isVoiceStopping = false
end

return slot0
