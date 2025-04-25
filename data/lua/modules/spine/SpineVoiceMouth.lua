module("modules.spine.SpineVoiceMouth", package.seeall)

slot0 = class("SpineVoiceMouth")
slot1 = "pause"
slot2 = "auto_bizui|"

function slot0.ctor(slot0)
	slot1 = AudioMgr.instance
	slot0._audioGroup = slot1:getIdFromString("PlotVoice")
	slot0._mouthActionList = {
		[slot1:getIdFromString("Smallmouth")] = "xiao",
		[slot1:getIdFromString("Mediumsizedmouth")] = "zhong",
		[slot1:getIdFromString("Largemouth")] = "da"
	}
end

function slot0.onDestroy(slot0)
	slot0:removeTaskActions()

	slot0._spineVoice = nil
	slot0._voiceConfig = nil
	slot0._spine = nil
end

function slot0._onMouthEnd(slot0)
	if slot0._setComponentStop then
		return
	end

	slot0._setComponentStop = true

	if slot0._spineVoice then
		slot0._spineVoice:_onComponentStop(slot0)
	end
end

function slot0.forceNoMouth(slot0)
	slot0._forceNoMouth = true
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._specialConfig = CharacterDataConfig.instance:getMotionSpecial(slot3 and slot3:getResPath() or "")
	slot0._spineVoice = slot1
	slot0._voiceConfig = slot2
	slot0._spine = slot3
	slot0._hasAudio = AudioConfig.instance:getAudioCOById(slot2.audio)
	slot0._setComponentStop = false
	slot0._playLastOne = nil

	slot0:removeTaskActions()
	slot0:_checkPlayMouthActionList(slot0:getMouth(slot2))
end

function slot0._checkPlayMouthActionList(slot0, slot1)
	slot0:_playMouthActionList(slot1)
end

function slot0.getMouth(slot0, slot1)
	if slot0._spineVoice:getVoiceLang() == "zh" then
		return slot1.mouth
	else
		return slot1[slot2 .. "mouth"] or slot1.mouth
	end
end

function slot0.getFace(slot0, slot1)
	if slot0._spineVoice:getVoiceLang() == "zh" then
		return slot1.face
	else
		return slot1[slot2 .. "face"] or slot1.face
	end
end

function slot0._getFaceEndTime(slot0)
	slot2 = string.split(slot0:getFace(slot0._voiceConfig), "|")

	if not slot2[#slot2] then
		return
	end

	if #string.split(slot3, "#") >= 3 then
		return tonumber(slot4[3])
	end
end

function slot0._stopMouthRepeat(slot0)
	TaskDispatcher.cancelTask(slot0._mouthRepeat, slot0)
end

function slot0._configValidity(slot0, slot1, slot2)
	for slot6 = #slot1, 1, -1 do
		slot9 = true

		if #string.split(slot1[slot6], "#") == 3 then
			if slot2:hasAnimation("t_" .. slot8[1]) then
				slot9 = false
			end
		elseif string.find(slot7, uv0) then
			slot9 = false
		end

		if slot9 then
			logError(string.format("id：%s spine:%s,语音 mouth 无效的配置：%s mouth:%s", slot0._voiceConfig.audio, slot0._spine and slot0._spine:getResPath(), slot7, slot0._voiceConfig.mouth))
			table.remove(slot1, slot6)
		end
	end
end

function slot0._playMouthActionList(slot0, slot1)
	slot0._lastMouthId = nil
	slot0._pauseMouth = nil
	slot0._voiceStartTime = Time.time
	slot0._autoBizui = false

	if slot0._forceNoMouth then
		slot0:_onMouthEnd()

		return
	end

	if slot0._voiceConfig.heroId == 3038 and not slot0._hasAudio then
		slot0:_onMouthEnd()
	end

	if LuaUtil.isEmptyStr(slot1) then
		if slot0._hasAudio then
			TaskDispatcher.runRepeat(slot0._mouthRepeat, slot0, 0.03)
		else
			slot0:_onMouthEnd()
		end
	else
		slot0._mouthDelayCallbackList = {}

		if string.find(slot1, uv0) then
			slot0._faceEndTime = slot0:_getFaceEndTime()
			slot0._autoBizui = slot0._faceEndTime
			slot1 = string.gsub(slot1, uv0, "")
		end

		slot2 = nil

		if not string.nilorempty(slot1) then
			slot0:_configValidity(string.split(slot1, "|"), slot0._spine)
		else
			slot2 = {}
		end

		slot3 = #slot2
		slot4 = 0

		for slot9, slot10 in ipairs(slot2) do
			if slot0:_checkMouthParam(string.split(slot10, "#")) then
				slot12 = slot11[1]
				slot13 = tonumber(slot11[2])
				slot14 = tonumber(slot11[3])

				if SLFramework.FrameworkSettings.IsEditor then
					if slot14 < slot13 then
						logError(string.format("SpineVoiceMouth mouth配置后面的时间比前面的时间还小, mouthStart:%s > mouthEnd:%s", slot13, slot14))
					end

					if slot13 < slot4 then
						logError(string.format("SpineVoiceMouth mouth配置后面的时间比前面的时间还小, mouthStart:%s < lastMouthEnd:%s", slot13, slot4))
					end
				end

				if slot0._autoBizui and slot14 ~= slot13 then
					slot0:_addMouthBizui(false, slot4, slot13)
				end

				slot0:_addMouth(slot9 == slot3 and not slot0._autoBizui, slot12, slot13, slot14)

				slot4 = slot14
			end
		end

		if slot0._autoBizui then
			if slot0._faceEndTime < slot4 then
				slot6 = slot4
			end

			slot0:_addMouthBizui(false, slot4, slot6)
			slot0:_addMouthBizui(true, slot6, slot6 + 1)
		end

		if slot3 <= 0 then
			slot0:_onMouthEnd()
		end
	end
end

function slot0._checkMouthParam(slot0, slot1)
	if slot1[1] == uv0 then
		slot0._pauseMouth = slot1[2]

		return false
	end

	return true
end

function slot0._addMouth(slot0, slot1, slot2, slot3, slot4)
	function slot5()
		if uv0._spine then
			uv0._curMouth = "t_" .. uv1
			uv0._curMouthEnd = nil

			uv0._spine:setMouthAnimation(uv0._curMouth, true, 0)
		end
	end

	function slot6()
		if uv0._spine then
			uv0._playLastOne = true

			if uv1 then
				uv0:stopMouthCallback()
			else
				uv0:stopMouthCallback(true)
			end
		end
	end

	table.insert(slot0._mouthDelayCallbackList, slot5)
	table.insert(slot0._mouthDelayCallbackList, slot6)
	TaskDispatcher.runDelay(slot5, nil, slot3)
	TaskDispatcher.runDelay(slot6, nil, slot4)
end

function slot0._addMouthBizui(slot0, slot1, slot2, slot3)
	function slot4()
		if uv0._spine then
			if uv0._spine:hasAnimation("t_" .. string.gsub(uv0._spine:getCurFace(), "e_", "") .. "_bizui") then
				uv0._curMouth = slot2

				uv0._spine:setMouthAnimation(uv0._curMouth, true, 0)

				return
			end

			if uv0._spine:hasAnimation(StoryAnimName.T_BiZui) then
				uv0._curMouth = StoryAnimName.T_BiZui

				uv0._spine:setMouthAnimation(uv0._curMouth, true, 0)
			end
		end
	end

	function slot5()
		if uv0._spine then
			uv0._playLastOne = true

			if uv1 then
				uv0:stopMouthCallback()
			else
				uv0:stopMouthCallback(true)
			end
		end
	end

	table.insert(slot0._mouthDelayCallbackList, slot4)
	table.insert(slot0._mouthDelayCallbackList, slot5)
	TaskDispatcher.runDelay(slot4, nil, slot2)
	TaskDispatcher.runDelay(slot5, nil, slot3)
end

function slot0._mouthRepeat(slot0)
	slot1 = Time.time

	if slot0._lastMouthId ~= AudioMgr.instance:getSwitch(slot0._audioGroup) then
		slot0._lastMouthId = slot2

		if slot0._mouthActionList[slot2] then
			slot0._curMouth = "t_" .. slot0._mouthActionList[slot2]
			slot0._curMouthEnd = nil

			slot0._spine:setMouthAnimation(slot0._curMouth, false, 0)
		else
			slot0:stopMouth()
		end
	end

	if slot2 == 0 and slot1 - slot0._voiceStartTime >= 1 then
		TaskDispatcher.cancelTask(slot0._mouthRepeat, slot0)
		slot0:_onMouthEnd()

		return
	end
end

function slot0.stopMouthCallback(slot0, slot1)
	slot0:stopMouth(slot1)
end

function slot0.stopMouth(slot0, slot1)
	if slot1 then
		slot0._curMouthEnd = nil

		if slot0._specialConfig and slot0._specialConfig.skipStopMouth == 1 then
			return
		end

		if slot0._spine then
			slot0._spine:stopMouthAnimation()
		end
	elseif slot0._curMouth then
		slot0:_setBiZui()

		slot0._curMouthEnd = slot0._curMouth
		slot0._curMouth = nil
	end
end

function slot0._setBiZui(slot0)
	if slot0._spine:hasAnimation(StoryAnimName.T_BiZui) then
		slot0._curMouth = StoryAnimName.T_BiZui

		slot0._spine:setMouthAnimation(slot0._curMouth, false, 0)
	end
end

function slot0.checkMouthEnd(slot0, slot1)
	if slot1 == slot0._curMouthEnd then
		slot0:stopMouth(true)
		slot0:_onMouthEnd()

		return true
	end
end

function slot0._clearAutoMouthCallback(slot0)
	if not slot0._mouthDelayCallbackList then
		return
	end

	for slot4, slot5 in ipairs(slot0._mouthDelayCallbackList) do
		TaskDispatcher.cancelTask(slot5, nil)
	end

	slot0._mouthDelayCallbackList = nil
end

function slot0.onVoiceStop(slot0)
	slot0:stopMouth(true)
	slot0:removeTaskActions()
end

function slot0.removeTaskActions(slot0)
	slot0:_stopMouthRepeat()
	slot0:_clearAutoMouthCallback()
end

return slot0
