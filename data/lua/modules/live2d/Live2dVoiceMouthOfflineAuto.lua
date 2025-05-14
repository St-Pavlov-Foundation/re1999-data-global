module("modules.live2d.Live2dVoiceMouthOfflineAuto", package.seeall)

local var_0_0 = class("Live2dVoiceMouthOfflineAuto", SpineVoiceMouth)

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

	if arg_1_0._forceNoMouth then
		arg_1_0:_onMouthEnd()

		return
	end

	if arg_1_0._voiceConfig.heroId == 3038 and not arg_1_0._hasAudio then
		arg_1_0:_onMouthEnd()
	end

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

		local var_1_0

		if not string.nilorempty(arg_1_1) then
			var_1_0 = string.split(arg_1_1, "|")

			arg_1_0:_configValidity(var_1_0, arg_1_0._spine)
		else
			var_1_0 = {}
		end

		arg_1_0:startLipSync()

		local var_1_1 = #var_1_0

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_2 = string.split(iter_1_1, "#")
			local var_1_3 = var_1_2[1]
			local var_1_4 = tonumber(var_1_2[2])
			local var_1_5 = tonumber(var_1_2[3])

			if arg_1_0:_hasAuto(var_1_3) and var_1_3 ~= var_0_0.AutoActionName then
				arg_1_0._forceFace = string.gsub(var_1_3, var_0_0.AutoActionName, "")
				var_1_3 = var_0_0.AutoActionName
			end

			if not arg_1_0:_hasAuto(var_1_3) then
				arg_1_0:_addMouth(iter_1_0 == var_1_1, var_1_3, var_1_4, var_1_5)
			end
		end

		if var_1_1 <= 0 then
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

function var_0_0.startLipSync(arg_7_0)
	local var_7_0 = arg_7_0._spine and arg_7_0._spine:getMouthController()

	if not gohelper.isNil(var_7_0) then
		var_7_0:StartListen()
		TaskDispatcher.runRepeat(arg_7_0._lipSyncUpdate, arg_7_0, 0.01, 2000)
	end
end

function var_0_0.stopLipSync(arg_8_0)
	local var_8_0 = arg_8_0._spine and arg_8_0._spine:getMouthController()

	if not gohelper.isNil(var_8_0) then
		var_8_0:Stop()
	end

	TaskDispatcher.cancelTask(arg_8_0._lipSyncUpdate, arg_8_0)
end

function var_0_0._lipSyncUpdate(arg_9_0)
	local var_9_0 = arg_9_0._spine._cubismMouthController.MouthValue

	if arg_9_0._manualMouthRunning then
		return
	end

	local var_9_1 = Time.time - arg_9_0._voiceStartTime
	local var_9_2 = arg_9_0:_getFaceActionList()
	local var_9_3

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		if var_9_1 >= iter_9_1[2] and var_9_1 < iter_9_1[3] then
			var_9_3 = iter_9_1[1]
		end
	end

	if arg_9_0._forceFace then
		var_9_3 = arg_9_0._forceFace
	end

	local var_9_4 = var_9_3 and "t_" .. var_9_3

	arg_9_0._lastFaceAction = var_9_3 or arg_9_0._lastFaceAction

	if var_9_0 > var_0_0.AutoMouthThreshold then
		if var_9_3 and arg_9_0._spine:hasAnimation(var_9_4) then
			if var_9_4 ~= arg_9_0._curMouth then
				arg_9_0._curMouth = var_9_4
				arg_9_0._curMouthEnd = nil

				arg_9_0._spine:setMouthAnimation(arg_9_0._curMouth, true, 0)
			end
		elseif arg_9_0._spine:hasAnimation(StoryAnimName.T_ZhengChang) and arg_9_0._curMouth ~= StoryAnimName.T_ZhengChang then
			arg_9_0._curMouth = StoryAnimName.T_ZhengChang

			arg_9_0._spine:setMouthAnimation(arg_9_0._curMouth, true, 0)
		end
	else
		arg_9_0:_setBiZui()
	end
end

function var_0_0._getFaceActionList(arg_10_0)
	if not arg_10_0._faceActionSpList then
		arg_10_0._faceActionSpList = {}

		local var_10_0 = arg_10_0:getFace(arg_10_0._voiceConfig)
		local var_10_1 = string.split(var_10_0, "|")

		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			local var_10_2 = string.split(iter_10_1, "#")

			if #var_10_2 >= 3 then
				local var_10_3 = var_10_2[1]
				local var_10_4 = tonumber(var_10_2[2])
				local var_10_5 = tonumber(var_10_2[3])

				table.insert(arg_10_0._faceActionSpList, {
					var_10_3,
					var_10_4,
					var_10_5
				})
			end
		end
	end

	return arg_10_0._faceActionSpList
end

function var_0_0._mouthRepeat(arg_11_0)
	return
end

function var_0_0._setBiZui(arg_12_0)
	if not string.nilorempty(arg_12_0._lastFaceAction) and not arg_12_0._isVoiceStop then
		local var_12_0 = string.format("t_%s_%s", arg_12_0._lastFaceAction, "bizui")

		if arg_12_0._spine:hasAnimation(var_12_0) then
			if arg_12_0._curMouth ~= var_12_0 then
				arg_12_0._curMouth = var_12_0

				arg_12_0._spine:setMouthAnimation(arg_12_0._curMouth, true, 0)
			end

			return
		end
	end

	if arg_12_0._curMouth ~= StoryAnimName.T_BiZui then
		if arg_12_0._spine:hasAnimation(StoryAnimName.T_BiZui) then
			arg_12_0._curMouth = StoryAnimName.T_BiZui

			arg_12_0._spine:setMouthAnimation(arg_12_0._curMouth, true, 0)
		else
			arg_12_0._curMouth = StoryAnimName.T_BiZui

			logError("no animation:t_bizui, heroId = " .. (arg_12_0._voiceConfig and arg_12_0._voiceConfig.heroId or "nil"))
		end
	end
end

function var_0_0.onVoiceStop(arg_13_0)
	arg_13_0._isVoiceStop = true

	arg_13_0:stopMouth()

	arg_13_0._isVoiceStop = false

	arg_13_0:removeTaskActions()

	arg_13_0._autoMouthRunning = false
	arg_13_0._manualMouthRunning = false
	arg_13_0._faceActionSpList = nil
end

function var_0_0.removeTaskActions(arg_14_0)
	var_0_0.super.removeTaskActions(arg_14_0)
	arg_14_0:stopLipSync()
end

function var_0_0.suspend(arg_15_0)
	arg_15_0:removeTaskActions()
end

return var_0_0
