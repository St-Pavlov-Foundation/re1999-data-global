module("modules.live2d.Live2dVoiceMouthOfflineAuto", package.seeall)

slot0 = class("Live2dVoiceMouthOfflineAuto", SpineVoiceMouth)
slot0.AutoActionName = "_auto"
slot0.AutoMouthThreshold = 0.1

function slot0._playMouthActionList(slot0, slot1)
	slot0._lastMouthId = nil
	slot0._lastFaceAction = nil
	slot0._faceActionSpList = nil
	slot0._voiceStartTime = Time.time
	slot0._autoMouthRunning = false
	slot0._manualMouthRunning = false
	slot0._forceFace = nil

	if slot0._forceNoMouth then
		slot0:_onMouthEnd()

		return
	end

	if slot0._voiceConfig.heroId == 3038 and not slot0._hasAudio then
		slot0:_onMouthEnd()
	end

	logNormal("start audio mouth: " .. tostring(slot1))
	logNormal("start audio face: " .. slot0:getFace(slot0._voiceConfig))

	if LuaUtil.isEmptyStr(slot1) then
		if slot0._hasAudio then
			TaskDispatcher.runRepeat(slot0._mouthRepeat, slot0, 0.03, 2000)
		else
			slot0:_onMouthEnd()
		end
	else
		slot0._mouthDelayCallbackList = {}
		slot2 = nil

		if not string.nilorempty(slot1) then
			slot0:_configValidity(string.split(slot1, "|"), slot0._spine)
		else
			slot2 = {}
		end

		slot0:startLipSync()

		slot3 = #slot2

		for slot7, slot8 in ipairs(slot2) do
			slot9 = string.split(slot8, "#")
			slot11 = tonumber(slot9[2])
			slot12 = tonumber(slot9[3])

			if slot0:_hasAuto(slot9[1]) and slot10 ~= uv0.AutoActionName then
				slot0._forceFace = string.gsub(slot10, uv0.AutoActionName, "")
				slot10 = uv0.AutoActionName
			end

			if not slot0:_hasAuto(slot10) then
				slot0:_addMouth(slot7 == slot3, slot10, slot11, slot12)
			end
		end

		if slot3 <= 0 then
			slot0:_onMouthEnd()
		end
	end
end

function slot0._hasAuto(slot0, slot1)
	return string.find(slot1, uv0.AutoActionName)
end

function slot0._configValidity(slot0, slot1, slot2)
	for slot6 = #slot1, 1, -1 do
		slot9 = true

		if #string.split(slot1[slot6], "#") == 3 and (slot2:hasAnimation("t_" .. slot8[1]) or slot0:_hasAuto(slot8[1])) then
			slot9 = false
		end

		if slot9 then
			logError(string.format("id：%s 语音 mouth 无效的配置：%s mouth:%s", slot0._voiceConfig.audio, slot7, slot0._voiceConfig.mouth))
			table.remove(slot1, slot6)
		end
	end
end

function slot0._addMouth(slot0, slot1, slot2, slot3, slot4)
	table.insert(slot0._mouthDelayCallbackList, function ()
		if uv0._spine then
			uv0._curMouth = "t_" .. uv1
			uv0._lastFaceAction = uv1 or uv0._lastFaceAction
			uv0._curMouthEnd = nil

			uv0._spine:setMouthAnimation(uv0._curMouth, true, 0)

			uv0._manualMouthRunning = true
		end
	end)
	table.insert(slot0._mouthDelayCallbackList, function ()
		if uv0._spine then
			uv0:stopMouthCallback(true)

			uv0._manualMouthRunning = false

			if uv0._autoMouthRunning then
				-- Nothing
			end
		end
	end)

	if slot3 > 0 then
		TaskDispatcher.runDelay(slot5, nil, slot3)
	else
		slot5()
	end

	TaskDispatcher.runDelay(slot6, nil, slot4)
end

function slot0.startLipSync(slot0)
	if not gohelper.isNil(slot0._spine and slot0._spine:getMouthController()) then
		slot1:StartListen()
		TaskDispatcher.runRepeat(slot0._lipSyncUpdate, slot0, 0.01, 2000)
	end
end

function slot0.stopLipSync(slot0)
	if not gohelper.isNil(slot0._spine and slot0._spine:getMouthController()) then
		slot1:Stop()
	end

	TaskDispatcher.cancelTask(slot0._lipSyncUpdate, slot0)
end

function slot0._lipSyncUpdate(slot0)
	slot1 = slot0._spine._cubismMouthController.MouthValue

	if slot0._manualMouthRunning then
		return
	end

	slot2 = Time.time - slot0._voiceStartTime
	slot4 = nil

	for slot8, slot9 in ipairs(slot0:_getFaceActionList()) do
		if slot9[2] <= slot2 and slot2 < slot9[3] then
			slot4 = slot9[1]
		end
	end

	if slot0._forceFace then
		slot4 = slot0._forceFace
	end

	slot5 = slot4 and "t_" .. slot4
	slot0._lastFaceAction = slot4 or slot0._lastFaceAction

	if uv0.AutoMouthThreshold < slot1 then
		if slot4 and slot0._spine:hasAnimation(slot5) then
			if slot5 ~= slot0._curMouth then
				slot0._curMouth = slot5
				slot0._curMouthEnd = nil

				slot0._spine:setMouthAnimation(slot0._curMouth, true, 0)
			end
		elseif slot0._spine:hasAnimation(StoryAnimName.T_ZhengChang) and slot0._curMouth ~= StoryAnimName.T_ZhengChang then
			slot0._curMouth = StoryAnimName.T_ZhengChang

			slot0._spine:setMouthAnimation(slot0._curMouth, true, 0)
		end
	else
		slot0:_setBiZui()
	end
end

function slot0._getFaceActionList(slot0)
	if not slot0._faceActionSpList then
		slot0._faceActionSpList = {}

		for slot6, slot7 in ipairs(string.split(slot0:getFace(slot0._voiceConfig), "|")) do
			if #string.split(slot7, "#") >= 3 then
				table.insert(slot0._faceActionSpList, {
					slot8[1],
					tonumber(slot8[2]),
					tonumber(slot8[3])
				})
			end
		end
	end

	return slot0._faceActionSpList
end

function slot0._mouthRepeat(slot0)
end

function slot0._setBiZui(slot0)
	if not string.nilorempty(slot0._lastFaceAction) and not slot0._isVoiceStop and slot0._spine:hasAnimation(string.format("t_%s_%s", slot0._lastFaceAction, "bizui")) then
		if slot0._curMouth ~= slot1 then
			slot0._curMouth = slot1

			slot0._spine:setMouthAnimation(slot0._curMouth, true, 0)
		end

		return
	end

	if slot0._curMouth ~= StoryAnimName.T_BiZui then
		if slot0._spine:hasAnimation(StoryAnimName.T_BiZui) then
			slot0._curMouth = StoryAnimName.T_BiZui

			slot0._spine:setMouthAnimation(slot0._curMouth, true, 0)
		else
			slot0._curMouth = StoryAnimName.T_BiZui

			logError("no animation:t_bizui, heroId = " .. (slot0._voiceConfig and slot0._voiceConfig.heroId or "nil"))
		end
	end
end

function slot0.onVoiceStop(slot0)
	slot0._isVoiceStop = true

	slot0:stopMouth()

	slot0._isVoiceStop = false

	slot0:removeTaskActions()

	slot0._autoMouthRunning = false
	slot0._manualMouthRunning = false
	slot0._faceActionSpList = nil
end

function slot0.removeTaskActions(slot0)
	uv0.super.removeTaskActions(slot0)
	slot0:stopLipSync()
end

function slot0.suspend(slot0)
	slot0:removeTaskActions()
end

return slot0
