module("modules.live2d.Live2dVoiceMouthAuto", package.seeall)

local var_0_0 = class("Live2dVoiceMouthAuto", SpineVoiceMouth)

var_0_0.AutoActionName = "_auto"
var_0_0.AutoMouthThreshold = 0.1

function var_0_0._playMouthActionList(arg_1_0, arg_1_1)
	arg_1_0._lastMouthId = nil
	arg_1_0._lastFaceAction = nil
	arg_1_0._faceActionSpList = nil
	arg_1_0._voiceStartTime = Time.time
	arg_1_0._autoMouthRunning = false
	arg_1_0._manualMouthRunning = false
	arg_1_0._forceFace = nil
	arg_1_0._isBiZui = true

	if arg_1_0._forceNoMouth then
		arg_1_0:_onMouthEnd()

		return
	end

	if arg_1_0._voiceConfig.heroId == 3038 and not arg_1_0._hasAudio then
		arg_1_0:_onMouthEnd()
	end

	arg_1_0._mouthAudioId = arg_1_0._voiceConfig.audio or arg_1_0._voiceConfig.storyAudioId

	local var_1_0 = arg_1_0._voiceConfig.heroId

	arg_1_0._voiceShortcut = GameConfig:GetCurVoiceShortcut()

	if var_1_0 then
		local var_1_1, var_1_2, var_1_3 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_1_0)
		local var_1_4 = LangSettings.shortcutTab[var_1_1]
		local var_1_5 = GameConfig:GetCurVoiceShortcut()

		if not string.nilorempty(var_1_4) and not var_1_3 then
			arg_1_0._voiceShortcut = var_1_4
		end
	end

	arg_1_0._autoMouthData = AudioConfig.instance:getAutoMouthData(arg_1_0._mouthAudioId, arg_1_0._voiceShortcut)

	logNormal("start audio mouth: " .. tostring(arg_1_1))
	logNormal("start audio face: " .. arg_1_0:getFace(arg_1_0._voiceConfig))

	if LuaUtil.isEmptyStr(arg_1_1) then
		if arg_1_0._hasAudio then
			TaskDispatcher.runRepeat(arg_1_0._mouthRepeat, arg_1_0, 0.03, 2000)
		else
			arg_1_0:_onMouthEnd()
		end
	else
		arg_1_0._mouthDelayCallbackList = {}

		local var_1_6

		if not string.nilorempty(arg_1_1) then
			var_1_6 = string.split(arg_1_1, "|")

			arg_1_0:_configValidity(var_1_6, arg_1_0._spine)
		else
			var_1_6 = {}
		end

		arg_1_0:startLipSync()

		local var_1_7 = #var_1_6

		for iter_1_0, iter_1_1 in ipairs(var_1_6) do
			local var_1_8 = string.split(iter_1_1, "#")
			local var_1_9 = var_1_8[1]
			local var_1_10 = tonumber(var_1_8[2])
			local var_1_11 = tonumber(var_1_8[3])

			if arg_1_0:_hasAuto(var_1_9) and var_1_9 ~= var_0_0.AutoActionName then
				arg_1_0._forceFace = string.gsub(var_1_9, var_0_0.AutoActionName, "")
				var_1_9 = var_0_0.AutoActionName
			end

			if not arg_1_0:_hasAuto(var_1_9) then
				arg_1_0:_addMouth(iter_1_0 == var_1_7, var_1_9, var_1_10, var_1_11)
			end
		end

		if var_1_7 <= 0 then
			arg_1_0:_onMouthEnd()
		end
	end
end

function var_0_0._hasAuto(arg_2_0, arg_2_1)
	return string.find(arg_2_1, var_0_0.AutoActionName)
end

function var_0_0._configValidity(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0 = #arg_3_1, 1, -1 do
		local var_3_0 = arg_3_1[iter_3_0]
		local var_3_1 = string.split(var_3_0, "#")
		local var_3_2 = true

		if #var_3_1 == 3 then
			local var_3_3 = "t_" .. var_3_1[1]

			if arg_3_2:hasAnimation(var_3_3) or arg_3_0:_hasAuto(var_3_1[1]) then
				var_3_2 = false
			end
		end

		if var_3_2 then
			logError(string.format("id：%s 语音 mouth 无效的配置：%s mouth:%s", arg_3_0._voiceConfig.audio, var_3_0, arg_3_0._voiceConfig.mouth))
			table.remove(arg_3_1, iter_3_0)
		end
	end
end

function var_0_0._addMouth(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local function var_4_0()
		if arg_4_0._spine then
			arg_4_0._curMouth = "t_" .. arg_4_2
			arg_4_0._lastFaceAction = arg_4_2 or arg_4_0._lastFaceAction
			arg_4_0._curMouthEnd = nil

			arg_4_0._spine:setMouthAnimation(arg_4_0._curMouth, true, 0)

			arg_4_0._manualMouthRunning = true
		end
	end

	local function var_4_1()
		if arg_4_0._spine then
			arg_4_0:stopMouthCallback(true)

			arg_4_0._manualMouthRunning = false

			if arg_4_0._autoMouthRunning then
				-- block empty
			end
		end
	end

	table.insert(arg_4_0._mouthDelayCallbackList, var_4_0)
	table.insert(arg_4_0._mouthDelayCallbackList, var_4_1)

	if arg_4_3 > 0 then
		TaskDispatcher.runDelay(var_4_0, nil, arg_4_3)
	else
		var_4_0()
	end

	TaskDispatcher.runDelay(var_4_1, nil, arg_4_4)
end

function var_0_0._dealOfflineCfg(arg_7_0)
	if arg_7_0._autoMouthData then
		local var_7_0 = #arg_7_0._autoMouthData

		for iter_7_0 = 1, var_7_0, 2 do
			local var_7_1 = arg_7_0._autoMouthData[iter_7_0]
			local var_7_2 = arg_7_0._autoMouthData[iter_7_0 + 1]

			arg_7_0:_addOfflineMouth(var_7_1, var_7_2)
		end
	end
end

function var_0_0._addOfflineMouth(arg_8_0, arg_8_1, arg_8_2)
	local function var_8_0()
		if arg_8_0._spine then
			arg_8_0:_setOpenMouth()
		end
	end

	local function var_8_1()
		if arg_8_0._spine then
			arg_8_0:_setBiZui()
		end
	end

	table.insert(arg_8_0._mouthDelayCallbackList, var_8_0)
	table.insert(arg_8_0._mouthDelayCallbackList, var_8_1)

	if arg_8_1 > 0 then
		TaskDispatcher.runDelay(var_8_0, nil, arg_8_1)
	else
		var_8_0()
	end

	if arg_8_2 then
		TaskDispatcher.runDelay(var_8_1, nil, arg_8_2)
	end
end

function var_0_0.startLipSync(arg_11_0)
	if arg_11_0._autoMouthData then
		arg_11_0:_dealOfflineCfg()
	elseif arg_11_0._mouthAudioId ~= 0 then
		logError("no offlineCfg", arg_11_0._mouthAudioId)
	end

	TaskDispatcher.runRepeat(arg_11_0._checkBiZuiUpdate, arg_11_0, 0.01, 2000)
end

function var_0_0.stopLipSync(arg_12_0)
	if arg_12_0._autoMouthData then
		-- block empty
	end

	TaskDispatcher.cancelTask(arg_12_0._checkBiZuiUpdate, arg_12_0)
end

function var_0_0._lipSyncUpdate(arg_13_0)
	local var_13_0 = arg_13_0._spine._cubismMouthController.MouthValue

	if arg_13_0._manualMouthRunning then
		return
	end

	local var_13_1 = Time.time - arg_13_0._voiceStartTime
	local var_13_2 = arg_13_0:_getFaceActionList()
	local var_13_3

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		if var_13_1 >= iter_13_1[2] and var_13_1 < iter_13_1[3] then
			var_13_3 = iter_13_1[1]
		end
	end

	if arg_13_0._forceFace then
		var_13_3 = arg_13_0._forceFace
	end

	local var_13_4 = var_13_3 and "t_" .. var_13_3

	arg_13_0._lastFaceAction = var_13_3 or arg_13_0._lastFaceAction

	if var_13_0 > var_0_0.AutoMouthThreshold then
		if var_13_3 and arg_13_0._spine:hasAnimation(var_13_4) then
			if var_13_4 ~= arg_13_0._curMouth then
				arg_13_0._curMouth = var_13_4
				arg_13_0._curMouthEnd = nil

				arg_13_0._spine:setMouthAnimation(arg_13_0._curMouth, true, 0)
			end
		elseif arg_13_0._spine:hasAnimation(StoryAnimName.T_ZhengChang) and arg_13_0._curMouth ~= StoryAnimName.T_ZhengChang then
			arg_13_0._curMouth = StoryAnimName.T_ZhengChang

			arg_13_0._spine:setMouthAnimation(arg_13_0._curMouth, true, 0)
		end
	else
		arg_13_0:_setBiZui()
	end
end

function var_0_0._getFaceActionList(arg_14_0)
	if not arg_14_0._faceActionSpList then
		arg_14_0._faceActionSpList = {}

		local var_14_0 = arg_14_0:getFace(arg_14_0._voiceConfig)
		local var_14_1 = string.split(var_14_0, "|")

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			local var_14_2 = string.split(iter_14_1, "#")

			if #var_14_2 >= 3 then
				local var_14_3 = var_14_2[1]
				local var_14_4 = tonumber(var_14_2[2])
				local var_14_5 = tonumber(var_14_2[3])

				table.insert(arg_14_0._faceActionSpList, {
					var_14_3,
					var_14_4,
					var_14_5
				})
			end
		end
	end

	return arg_14_0._faceActionSpList
end

function var_0_0._mouthRepeat(arg_15_0)
	return
end

function var_0_0._setOpenMouth(arg_16_0)
	arg_16_0._isBiZui = false

	local var_16_0 = arg_16_0:_getFaceActionList()
	local var_16_1
	local var_16_2 = Time.time - arg_16_0._voiceStartTime

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if var_16_2 >= iter_16_1[2] and var_16_2 < iter_16_1[3] then
			var_16_1 = iter_16_1[1]
		end
	end

	if arg_16_0._forceFace then
		var_16_1 = arg_16_0._forceFace
	end

	local var_16_3 = var_16_1 and "t_" .. var_16_1

	arg_16_0._lastFaceAction = var_16_1 or arg_16_0._lastFaceAction

	if var_16_1 and arg_16_0._spine:hasAnimation(var_16_3) then
		if var_16_3 ~= arg_16_0._curMouth then
			arg_16_0._curMouth = var_16_3
			arg_16_0._curMouthEnd = nil

			arg_16_0._spine:setMouthAnimation(arg_16_0._curMouth, true, 0)
		end
	elseif arg_16_0._spine:hasAnimation(StoryAnimName.T_ZhengChang) and arg_16_0._curMouth ~= StoryAnimName.T_ZhengChang then
		arg_16_0._curMouth = StoryAnimName.T_ZhengChang

		arg_16_0._spine:setMouthAnimation(arg_16_0._curMouth, true, 0)
	end
end

function var_0_0._checkBiZuiUpdate(arg_17_0)
	if arg_17_0._manualMouthRunning then
		return
	end

	if arg_17_0._isBiZui then
		local var_17_0 = Time.time - arg_17_0._voiceStartTime
		local var_17_1 = arg_17_0:_getFaceActionList()
		local var_17_2

		for iter_17_0, iter_17_1 in ipairs(var_17_1) do
			if var_17_0 >= iter_17_1[2] and var_17_0 < iter_17_1[3] then
				var_17_2 = iter_17_1[1]
			end
		end

		if arg_17_0._forceFace then
			var_17_2 = arg_17_0._forceFace
		end

		local var_17_3

		var_17_3 = var_17_2 and "t_" .. var_17_2
		arg_17_0._lastFaceAction = var_17_2 or arg_17_0._lastFaceAction

		arg_17_0:_setBiZui()
	end
end

function var_0_0._setBiZui(arg_18_0)
	arg_18_0._isBiZui = true

	if not string.nilorempty(arg_18_0._lastFaceAction) and not arg_18_0._isVoiceStop then
		local var_18_0 = string.format("t_%s_%s", arg_18_0._lastFaceAction, "bizui")

		if arg_18_0._spine:hasAnimation(var_18_0) then
			if arg_18_0._curMouth ~= var_18_0 then
				arg_18_0._curMouth = var_18_0

				arg_18_0._spine:setMouthAnimation(arg_18_0._curMouth, true, 0)
			end

			return
		end
	end

	if arg_18_0._curMouth ~= StoryAnimName.T_BiZui then
		if arg_18_0._spine:hasAnimation(StoryAnimName.T_BiZui) then
			arg_18_0._curMouth = StoryAnimName.T_BiZui

			arg_18_0._spine:setMouthAnimation(arg_18_0._curMouth, true, 0)
		else
			arg_18_0._curMouth = StoryAnimName.T_BiZui

			logError("no animation:t_bizui, heroId = " .. (arg_18_0._voiceConfig and arg_18_0._voiceConfig.heroId or "nil"))
		end
	end
end

function var_0_0.onVoiceStop(arg_19_0)
	arg_19_0._isVoiceStop = true

	arg_19_0:stopMouth()

	arg_19_0._isVoiceStop = false

	arg_19_0:removeTaskActions()

	arg_19_0._autoMouthRunning = false
	arg_19_0._manualMouthRunning = false
	arg_19_0._faceActionSpList = nil
end

function var_0_0.removeTaskActions(arg_20_0)
	var_0_0.super.removeTaskActions(arg_20_0)
	arg_20_0:stopLipSync()
end

function var_0_0.suspend(arg_21_0)
	arg_21_0:removeTaskActions()
end

return var_0_0
