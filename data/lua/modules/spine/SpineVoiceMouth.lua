module("modules.spine.SpineVoiceMouth", package.seeall)

local var_0_0 = class("SpineVoiceMouth")
local var_0_1 = "pause"
local var_0_2 = "auto_bizui|"

function var_0_0.ctor(arg_1_0)
	local var_1_0 = AudioMgr.instance

	arg_1_0._audioGroup = var_1_0:getIdFromString("PlotVoice")
	arg_1_0._mouthActionList = {
		[var_1_0:getIdFromString("Smallmouth")] = "xiao",
		[var_1_0:getIdFromString("Mediumsizedmouth")] = "zhong",
		[var_1_0:getIdFromString("Largemouth")] = "da"
	}
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0:removeTaskActions()

	arg_2_0._spineVoice = nil
	arg_2_0._voiceConfig = nil
	arg_2_0._spine = nil
end

function var_0_0._onMouthEnd(arg_3_0)
	if arg_3_0._setComponentStop then
		return
	end

	arg_3_0._setComponentStop = true

	if arg_3_0._spineVoice then
		arg_3_0._spineVoice:_onComponentStop(arg_3_0)
	end
end

function var_0_0.forceNoMouth(arg_4_0)
	arg_4_0._forceNoMouth = true
end

function var_0_0.init(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._specialConfig = CharacterDataConfig.instance:getMotionSpecial(arg_5_3 and arg_5_3:getResPath() or "")
	arg_5_0._spineVoice = arg_5_1
	arg_5_0._voiceConfig = arg_5_2
	arg_5_0._spine = arg_5_3
	arg_5_0._hasAudio = AudioConfig.instance:getAudioCOById(arg_5_2.audio)
	arg_5_0._setComponentStop = false
	arg_5_0._playLastOne = nil

	arg_5_0:removeTaskActions()

	local var_5_0 = arg_5_0:getMouth(arg_5_2)

	arg_5_0:_checkPlayMouthActionList(var_5_0)
end

function var_0_0._checkPlayMouthActionList(arg_6_0, arg_6_1)
	arg_6_0:_playMouthActionList(arg_6_1)
end

function var_0_0.getMouth(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._spineVoice:getVoiceLang()

	if var_7_0 == "zh" then
		return arg_7_1.mouth
	else
		return arg_7_1[var_7_0 .. "mouth"] or arg_7_1.mouth
	end
end

function var_0_0.getFace(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._spineVoice:getVoiceLang()

	if var_8_0 == "zh" then
		return arg_8_1.face
	else
		return arg_8_1[var_8_0 .. "face"] or arg_8_1.face
	end
end

function var_0_0._getFaceEndTime(arg_9_0)
	local var_9_0 = arg_9_0:getFace(arg_9_0._voiceConfig)
	local var_9_1 = string.split(var_9_0, "|")
	local var_9_2 = var_9_1[#var_9_1]

	if not var_9_2 then
		return
	end

	local var_9_3 = string.split(var_9_2, "#")

	if #var_9_3 >= 3 then
		return (tonumber(var_9_3[3]))
	end
end

function var_0_0._stopMouthRepeat(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._mouthRepeat, arg_10_0)
end

function var_0_0._configValidity(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = #arg_11_1, 1, -1 do
		local var_11_0 = arg_11_1[iter_11_0]
		local var_11_1 = string.split(var_11_0, "#")
		local var_11_2 = true

		if #var_11_1 == 3 then
			local var_11_3 = "t_" .. var_11_1[1]

			if arg_11_2:hasAnimation(var_11_3) then
				var_11_2 = false
			end
		elseif string.find(var_11_0, var_0_1) then
			var_11_2 = false
		end

		if var_11_2 then
			logError(string.format("id：%s spine:%s,语音 mouth 无效的配置：%s mouth:%s", arg_11_0._voiceConfig.audio, arg_11_0._spine and arg_11_0._spine:getResPath(), var_11_0, arg_11_0._voiceConfig.mouth))
			table.remove(arg_11_1, iter_11_0)
		end
	end
end

function var_0_0._playMouthActionList(arg_12_0, arg_12_1)
	arg_12_0._lastMouthId = nil
	arg_12_0._pauseMouth = nil
	arg_12_0._voiceStartTime = Time.time
	arg_12_0._autoBizui = false

	if arg_12_0._forceNoMouth then
		arg_12_0:_onMouthEnd()

		return
	end

	if arg_12_0._voiceConfig.heroId == 3038 and not arg_12_0._hasAudio then
		arg_12_0:_onMouthEnd()
	end

	if LuaUtil.isEmptyStr(arg_12_1) then
		if arg_12_0._hasAudio then
			TaskDispatcher.runRepeat(arg_12_0._mouthRepeat, arg_12_0, 0.03)
		else
			arg_12_0:_onMouthEnd()
		end
	else
		arg_12_0._mouthDelayCallbackList = {}

		if string.find(arg_12_1, var_0_2) then
			arg_12_0._faceEndTime = arg_12_0:_getFaceEndTime()
			arg_12_0._autoBizui = arg_12_0._faceEndTime
			arg_12_1 = string.gsub(arg_12_1, var_0_2, "")
		end

		local var_12_0

		if not string.nilorempty(arg_12_1) then
			var_12_0 = string.split(arg_12_1, "|")

			arg_12_0:_configValidity(var_12_0, arg_12_0._spine)
		else
			var_12_0 = {}
		end

		local var_12_1 = #var_12_0
		local var_12_2 = 0
		local var_12_3 = SLFramework.FrameworkSettings.IsEditor

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_4 = string.split(iter_12_1, "#")

			if arg_12_0:_checkMouthParam(var_12_4) then
				local var_12_5 = var_12_4[1]
				local var_12_6 = tonumber(var_12_4[2])
				local var_12_7 = tonumber(var_12_4[3])

				if var_12_3 then
					if var_12_7 < var_12_6 then
						logError(string.format("SpineVoiceMouth audio:%s mouth配置后面的时间比前面的时间还小, mouthStart:%s > mouthEnd:%s", arg_12_0._voiceConfig.audio, var_12_6, var_12_7))
					end

					if var_12_6 < var_12_2 then
						logError(string.format("SpineVoiceMouth audio:%s mouth配置后面的时间比前面的时间还小, mouthStart:%s < lastMouthEnd:%s", arg_12_0._voiceConfig.audio, var_12_6, var_12_2))
					end
				end

				if arg_12_0._autoBizui and var_12_7 ~= var_12_6 then
					arg_12_0:_addMouthBizui(false, var_12_2, var_12_6)
				end

				arg_12_0:_addMouth(iter_12_0 == var_12_1 and not arg_12_0._autoBizui, var_12_5, var_12_6, var_12_7)

				var_12_2 = var_12_7
			end
		end

		if arg_12_0._autoBizui then
			local var_12_8 = arg_12_0._faceEndTime

			if var_12_8 < var_12_2 then
				var_12_8 = var_12_2
			end

			arg_12_0:_addMouthBizui(false, var_12_2, var_12_8)
			arg_12_0:_addMouthBizui(true, var_12_8, var_12_8 + 1)
		end

		if var_12_1 <= 0 then
			arg_12_0:_onMouthEnd()
		end
	end
end

function var_0_0._checkMouthParam(arg_13_0, arg_13_1)
	if arg_13_1[1] == var_0_1 then
		arg_13_0._pauseMouth = arg_13_1[2]

		return false
	end

	return true
end

function var_0_0._addMouth(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local function var_14_0()
		if arg_14_0._spine then
			arg_14_0._curMouth = "t_" .. arg_14_2
			arg_14_0._curMouthEnd = nil

			arg_14_0._spine:setMouthAnimation(arg_14_0._curMouth, true, 0)
		end
	end

	local function var_14_1()
		if arg_14_0._spine then
			arg_14_0._playLastOne = true

			if arg_14_1 then
				arg_14_0:stopMouthCallback()
			else
				arg_14_0:stopMouthCallback(true)
			end
		end
	end

	table.insert(arg_14_0._mouthDelayCallbackList, var_14_0)
	table.insert(arg_14_0._mouthDelayCallbackList, var_14_1)
	TaskDispatcher.runDelay(var_14_0, nil, arg_14_3)
	TaskDispatcher.runDelay(var_14_1, nil, arg_14_4)
end

function var_0_0._addMouthBizui(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local function var_17_0()
		if arg_17_0._spine then
			local var_18_0 = arg_17_0._spine:getCurFace()
			local var_18_1 = string.gsub(var_18_0, "e_", "")
			local var_18_2 = "t_" .. var_18_1 .. "_bizui"

			if arg_17_0._spine:hasAnimation(var_18_2) then
				arg_17_0._curMouth = var_18_2

				arg_17_0._spine:setMouthAnimation(arg_17_0._curMouth, true, 0)

				return
			end

			if arg_17_0._spine:hasAnimation(StoryAnimName.T_BiZui) then
				arg_17_0._curMouth = StoryAnimName.T_BiZui

				arg_17_0._spine:setMouthAnimation(arg_17_0._curMouth, true, 0)
			end
		end
	end

	local function var_17_1()
		if arg_17_0._spine then
			arg_17_0._playLastOne = true

			if arg_17_1 then
				arg_17_0:stopMouthCallback()
			else
				arg_17_0:stopMouthCallback(true)
			end
		end
	end

	table.insert(arg_17_0._mouthDelayCallbackList, var_17_0)
	table.insert(arg_17_0._mouthDelayCallbackList, var_17_1)
	TaskDispatcher.runDelay(var_17_0, nil, arg_17_2)
	TaskDispatcher.runDelay(var_17_1, nil, arg_17_3)
end

function var_0_0._mouthRepeat(arg_20_0)
	local var_20_0 = Time.time
	local var_20_1 = AudioMgr.instance:getSwitch(arg_20_0._audioGroup)

	if arg_20_0._lastMouthId ~= var_20_1 then
		arg_20_0._lastMouthId = var_20_1

		if arg_20_0._mouthActionList[var_20_1] then
			arg_20_0._curMouth = "t_" .. arg_20_0._mouthActionList[var_20_1]
			arg_20_0._curMouthEnd = nil

			arg_20_0._spine:setMouthAnimation(arg_20_0._curMouth, false, 0)
		else
			arg_20_0:stopMouth()
		end
	end

	local var_20_2 = var_20_0 - arg_20_0._voiceStartTime

	if var_20_1 == 0 and var_20_2 >= 1 then
		TaskDispatcher.cancelTask(arg_20_0._mouthRepeat, arg_20_0)
		arg_20_0:_onMouthEnd()

		return
	end
end

function var_0_0.stopMouthCallback(arg_21_0, arg_21_1)
	arg_21_0:stopMouth(arg_21_1)
end

function var_0_0.stopMouth(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0._curMouthEnd = nil

		if arg_22_0._specialConfig and arg_22_0._specialConfig.skipStopMouth == 1 then
			return
		end

		if arg_22_0._spine then
			arg_22_0._spine:stopMouthAnimation()
		end
	elseif arg_22_0._curMouth then
		arg_22_0:_setBiZui()

		arg_22_0._curMouthEnd = arg_22_0._curMouth
		arg_22_0._curMouth = nil
	end
end

function var_0_0._setBiZui(arg_23_0)
	if arg_23_0._spine:hasAnimation(StoryAnimName.T_BiZui) then
		arg_23_0._curMouth = StoryAnimName.T_BiZui

		arg_23_0._spine:setMouthAnimation(arg_23_0._curMouth, false, 0)
	end
end

function var_0_0.checkMouthEnd(arg_24_0, arg_24_1)
	if arg_24_1 == arg_24_0._curMouthEnd then
		arg_24_0:stopMouth(true)
		arg_24_0:_onMouthEnd()

		return true
	end
end

function var_0_0._clearAutoMouthCallback(arg_25_0)
	if not arg_25_0._mouthDelayCallbackList then
		return
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._mouthDelayCallbackList) do
		TaskDispatcher.cancelTask(iter_25_1, nil)
	end

	arg_25_0._mouthDelayCallbackList = nil
end

function var_0_0.onVoiceStop(arg_26_0)
	arg_26_0:stopMouth(true)
	arg_26_0:removeTaskActions()
end

function var_0_0.removeTaskActions(arg_27_0)
	arg_27_0:_stopMouthRepeat()
	arg_27_0:_clearAutoMouthCallback()
end

return var_0_0
