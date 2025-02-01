module("modules.live2d.Live2dVoiceMouthAuto", package.seeall)

slot0 = class("Live2dVoiceMouthAuto", SpineVoiceMouth)
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
	slot0._isBiZui = true

	if slot0._forceNoMouth then
		slot0:_onMouthEnd()

		return
	end

	if slot0._voiceConfig.heroId == 3038 and not slot0._hasAudio then
		slot0:_onMouthEnd()
	end

	slot0._mouthAudioId = slot0._voiceConfig.audio or slot0._voiceConfig.storyAudioId
	slot0._voiceShortcut = GameConfig:GetCurVoiceShortcut()

	if slot0._voiceConfig.heroId then
		slot3, slot4, slot5 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot2)
		slot7 = GameConfig:GetCurVoiceShortcut()

		if not string.nilorempty(LangSettings.shortcutTab[slot3]) and not slot5 then
			slot0._voiceShortcut = slot6
		end
	end

	slot0._autoMouthData = AudioConfig.instance:getAutoMouthData(slot0._mouthAudioId, slot0._voiceShortcut)

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
		slot3 = nil

		if not string.nilorempty(slot1) then
			slot0:_configValidity(string.split(slot1, "|"), slot0._spine)
		else
			slot3 = {}
		end

		slot0:startLipSync()

		slot4 = #slot3

		for slot8, slot9 in ipairs(slot3) do
			slot10 = string.split(slot9, "#")
			slot12 = tonumber(slot10[2])
			slot13 = tonumber(slot10[3])

			if slot0:_hasAuto(slot10[1]) and slot11 ~= uv0.AutoActionName then
				slot0._forceFace = string.gsub(slot11, uv0.AutoActionName, "")
				slot11 = uv0.AutoActionName
			end

			if not slot0:_hasAuto(slot11) then
				slot0:_addMouth(slot8 == slot4, slot11, slot12, slot13)
			end
		end

		if slot4 <= 0 then
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

function slot0._dealOfflineCfg(slot0)
	if slot0._autoMouthData then
		for slot5 = 1, #slot0._autoMouthData, 2 do
			slot0:_addOfflineMouth(slot0._autoMouthData[slot5], slot0._autoMouthData[slot5 + 1])
		end
	end
end

function slot0._addOfflineMouth(slot0, slot1, slot2)
	table.insert(slot0._mouthDelayCallbackList, function ()
		if uv0._spine then
			uv0:_setOpenMouth()
		end
	end)
	table.insert(slot0._mouthDelayCallbackList, function ()
		if uv0._spine then
			uv0:_setBiZui()
		end
	end)

	if slot1 > 0 then
		TaskDispatcher.runDelay(slot3, nil, slot1)
	else
		slot3()
	end

	if slot2 then
		TaskDispatcher.runDelay(slot4, nil, slot2)
	end
end

function slot0.startLipSync(slot0)
	if slot0._autoMouthData then
		slot0:_dealOfflineCfg()
	elseif slot0._mouthAudioId ~= 0 then
		logError("no offlineCfg", slot0._mouthAudioId)
	end

	TaskDispatcher.runRepeat(slot0._checkBiZuiUpdate, slot0, 0.01, 2000)
end

function slot0.stopLipSync(slot0)
	if slot0._autoMouthData then
		-- Nothing
	end

	TaskDispatcher.cancelTask(slot0._checkBiZuiUpdate, slot0)
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

function slot0._setOpenMouth(slot0)
	slot0._isBiZui = false
	slot2 = nil
	slot3 = Time.time - slot0._voiceStartTime

	for slot7, slot8 in ipairs(slot0:_getFaceActionList()) do
		if slot8[2] <= slot3 and slot3 < slot8[3] then
			slot2 = slot8[1]
		end
	end

	if slot0._forceFace then
		slot2 = slot0._forceFace
	end

	slot4 = slot2 and "t_" .. slot2
	slot0._lastFaceAction = slot2 or slot0._lastFaceAction

	if slot2 and slot0._spine:hasAnimation(slot4) then
		if slot4 ~= slot0._curMouth then
			slot0._curMouth = slot4
			slot0._curMouthEnd = nil

			slot0._spine:setMouthAnimation(slot0._curMouth, true, 0)
		end
	elseif slot0._spine:hasAnimation(StoryAnimName.T_ZhengChang) and slot0._curMouth ~= StoryAnimName.T_ZhengChang then
		slot0._curMouth = StoryAnimName.T_ZhengChang

		slot0._spine:setMouthAnimation(slot0._curMouth, true, 0)
	end
end

function slot0._checkBiZuiUpdate(slot0)
	if slot0._manualMouthRunning then
		return
	end

	if slot0._isBiZui then
		slot1 = Time.time - slot0._voiceStartTime
		slot3 = nil

		for slot7, slot8 in ipairs(slot0:_getFaceActionList()) do
			if slot8[2] <= slot1 and slot1 < slot8[3] then
				slot3 = slot8[1]
			end
		end

		if slot0._forceFace then
			slot3 = slot0._forceFace
		end

		slot4 = slot3 and "t_" .. slot3
		slot0._lastFaceAction = slot3 or slot0._lastFaceAction

		slot0:_setBiZui()
	end
end

function slot0._setBiZui(slot0)
	slot0._isBiZui = true

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
