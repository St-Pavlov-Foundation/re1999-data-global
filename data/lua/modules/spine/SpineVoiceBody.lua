module("modules.spine.SpineVoiceBody", package.seeall)

local var_0_0 = class("SpineVoiceBody")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0:removeTaskActions()

	arg_2_0._spineVoice = nil
	arg_2_0._voiceConfig = nil
	arg_2_0._spine = nil
end

function var_0_0.setBodyAnimation(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0._spine:getCurBody()
	local var_3_1 = arg_3_0:_getPlayMotionMixTime(arg_3_1)

	if var_3_1 then
		arg_3_3 = var_3_1
	end

	arg_3_0:_setBodyAnimation(arg_3_1, arg_3_2, arg_3_3, arg_3_0._motionCutList[var_3_0])
end

function var_0_0._getPlayMotionMixTime(arg_4_0, arg_4_1)
	if not arg_4_0._motionPlayCutList[arg_4_1] then
		return
	end

	if arg_4_0._motionPlayCutConfig.whenStopped == 1 and arg_4_0._isVoiceStopping then
		return 0
	end

	if arg_4_0._motionPlayCutConfig.whenNotStopped == 1 and not arg_4_0._isVoiceStopping then
		return 0
	end
end

function var_0_0._setBodyAnimation(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_4 then
		if not arg_5_0._onlyVoiceStopCut then
			arg_5_3 = 0
		end

		if arg_5_0._onlyVoiceStopCut and arg_5_0._isVoiceStopping then
			arg_5_3 = 0
		end
	end

	if arg_5_1 ~= arg_5_0._spine:getCurBody() then
		arg_5_0._spine:setBodyAnimation(arg_5_1, arg_5_2, arg_5_3 or 0.2)
	end
end

function var_0_0.init(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._spineVoice = arg_6_1
	arg_6_0._voiceConfig = arg_6_2
	arg_6_0._spine = arg_6_3
	arg_6_0._skinId = arg_6_3 and arg_6_3._skinId

	arg_6_0:_initCutMotion(arg_6_2)
	arg_6_0:_initPlayCutMotion(arg_6_2)

	arg_6_0._onlyVoiceStopCut = arg_6_0._motionCutConfig and arg_6_0._motionCutConfig.onlyStopCut == 1

	local var_6_0 = arg_6_0:getMotion(arg_6_2)

	arg_6_0:playBodyActionList(var_6_0)
end

function var_0_0.getSpineVoice(arg_7_0)
	return arg_7_0._spineVoice
end

function var_0_0.getMotion(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._spineVoice:getVoiceLang()

	if var_8_0 == "zh" then
		return arg_8_1.motion
	else
		return arg_8_1[var_8_0 .. "motion"] or arg_8_1.motion
	end
end

function var_0_0._getHeroId(arg_9_0, arg_9_1)
	if arg_9_1.storyHeroIndex then
		local var_9_0 = lua_story_hero_to_character.configDict[arg_9_1.storyHeroIndex]

		return var_9_0 and var_9_0.heroId
	end

	return arg_9_1.heroId
end

function var_0_0._initCutMotion(arg_10_0, arg_10_1)
	arg_10_0._motionCutList = {}
	arg_10_0._motionCutConfig = nil

	local var_10_0 = lua_character_motion_cut.configDict[arg_10_0:_getHeroId(arg_10_1)]

	if not var_10_0 then
		return
	end

	var_10_0 = arg_10_0._skinId and var_10_0[arg_10_0._skinId] or var_10_0[1]

	if not var_10_0 then
		return
	end

	arg_10_0._motionCutConfig = var_10_0

	local var_10_1 = var_10_0.motion
	local var_10_2 = string.split(var_10_1, "|")

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		arg_10_0._motionCutList["b_" .. iter_10_1] = true
	end
end

function var_0_0._initPlayCutMotion(arg_11_0, arg_11_1)
	arg_11_0._motionPlayCutList = {}
	arg_11_0._motionPlayCutConfig = nil

	local var_11_0 = lua_character_motion_play_cut.configDict[arg_11_0:_getHeroId(arg_11_1)]

	if not var_11_0 then
		return
	end

	var_11_0 = arg_11_0._skinId and var_11_0[arg_11_0._skinId] or var_11_0[1]

	if not var_11_0 then
		return
	end

	arg_11_0._motionPlayCutConfig = var_11_0

	local var_11_1 = var_11_0.motion
	local var_11_2 = string.split(var_11_1, "|")

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		arg_11_0._motionPlayCutList["b_" .. iter_11_1] = true
	end
end

function var_0_0._configValidity(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = #arg_12_1, 1, -1 do
		local var_12_0 = arg_12_1[iter_12_0]
		local var_12_1 = string.split(var_12_0, "#")
		local var_12_2 = true

		if var_12_1[2] then
			local var_12_3 = "b_" .. var_12_1[1]

			if arg_12_2:hasAnimation(var_12_3) then
				var_12_2 = false
			end
		end

		if var_12_2 then
			if SLFramework.FrameworkSettings.IsEditor then
				logWarn(string.format("编辑器下的调试log，无需在意。 id：%s 语音 body 无效的配置：%s motion:%s", arg_12_0._voiceConfig.audio, var_12_0, arg_12_0._motion))
			end

			table.remove(arg_12_1, iter_12_0)
		end
	end
end

function var_0_0.playBodyActionList(arg_13_0, arg_13_1)
	arg_13_0._bodyStart = 0
	arg_13_0._motion = arg_13_1

	if not string.nilorempty(arg_13_1) then
		arg_13_0._bodyList = string.split(arg_13_1, "|")

		arg_13_0:_configValidity(arg_13_0._bodyList, arg_13_0._spine)
	else
		arg_13_0._bodyList = {}
	end

	arg_13_0._appointIdleName = nil
	arg_13_0._appointIdleMixTime = nil

	arg_13_0:_playBodyAction()
end

function var_0_0._checkAppointIdle(arg_14_0)
	if arg_14_0._spineVoice:getInStory() and #arg_14_0._bodyList > 0 then
		local var_14_0 = arg_14_0._bodyList[1]
		local var_14_1 = string.split(var_14_0, "#")

		if var_14_1[3] == "-2" then
			arg_14_0._appointIdleName = "b_" .. var_14_1[1]
			arg_14_0._appointIdleMixTime = tonumber(var_14_1[4])

			table.remove(arg_14_0._bodyList, 1)
		end
	end
end

function var_0_0._playBodyAction(arg_15_0)
	arg_15_0._bodyActionName = nil
	arg_15_0._playBodyName = nil
	arg_15_0._nextActionStartTime = nil

	local var_15_0 = true
	local var_15_1 = true

	arg_15_0:_checkAppointIdle()
	TaskDispatcher.cancelTask(arg_15_0._bodyActionDelay, arg_15_0)

	if #arg_15_0._bodyList > 0 then
		local var_15_2 = table.remove(arg_15_0._bodyList, 1)
		local var_15_3 = string.split(var_15_2, "#")

		if var_15_3[2] then
			arg_15_0._bodyActionName = "b_" .. var_15_3[1]
			arg_15_0._actionLoop = var_15_3[3] == "-1"
			arg_15_0._mixTime = var_15_3[4] and tonumber(var_15_3[4])

			local var_15_4 = tonumber(var_15_3[2]) - arg_15_0._bodyStart

			arg_15_0._bodyStartTime = Time.time

			if var_15_4 > 0 then
				TaskDispatcher.runDelay(arg_15_0._bodyActionDelay, arg_15_0, var_15_4)
			else
				var_15_0 = false

				if arg_15_0._onlyVoiceStopCut then
					TaskDispatcher.runDelay(arg_15_0._bodyActionDelay, arg_15_0, 0)
				else
					arg_15_0:_bodyActionDelay()
				end
			end

			var_15_1 = false
		end
	end

	if var_15_0 then
		arg_15_0:setNormal()
	end

	arg_15_0:_startCheckLoopEnd()

	if var_15_1 then
		arg_15_0:_onBodyEnd()
	end
end

function var_0_0._startCheckLoopEnd(arg_16_0)
	arg_16_0._nextActionStartTime = nil

	TaskDispatcher.cancelTask(arg_16_0._checkLoopActionEnd, arg_16_0)

	if not arg_16_0._actionLoop then
		return
	end

	if #arg_16_0._bodyList > 0 then
		local var_16_0 = arg_16_0._bodyList[1]
		local var_16_1 = string.split(var_16_0, "#")

		if var_16_1[2] then
			local var_16_2 = tonumber(var_16_1[2]) - arg_16_0._bodyStart

			arg_16_0._nextActionStartTime = arg_16_0._bodyStartTime + var_16_2
		end
	end

	if arg_16_0._nextActionStartTime then
		TaskDispatcher.runRepeat(arg_16_0._checkLoopActionEnd, arg_16_0, 0)
	end
end

function var_0_0._checkLoopActionEnd(arg_17_0)
	if not arg_17_0._nextActionStartTime then
		TaskDispatcher.cancelTask(arg_17_0._checkLoopActionEnd, arg_17_0)

		return
	end

	if arg_17_0._nextActionStartTime <= Time.time then
		TaskDispatcher.cancelTask(arg_17_0._checkLoopActionEnd, arg_17_0)

		arg_17_0._bodyStart = arg_17_0._bodyStart + (Time.time - arg_17_0._bodyStartTime)

		arg_17_0:_playBodyAction()
	end
end

function var_0_0._onBodyEnd(arg_18_0)
	arg_18_0._spineVoice:_onComponentStop(arg_18_0)
end

function var_0_0.setNormal(arg_19_0)
	if not arg_19_0._spineVoice then
		return
	end

	if arg_19_0._appointIdleName then
		arg_19_0:setBodyAnimation(arg_19_0._appointIdleName, true, arg_19_0._appointIdleMixTime)

		arg_19_0._appointIdleMixTime = nil

		return
	end

	local var_19_0 = arg_19_0._spineVoice:getInStory() and StoryAnimName.B_IDLE or CharacterVoiceController.instance:getIdle(arg_19_0._voiceConfig.heroId)

	arg_19_0:setBodyAnimation(var_19_0, true)
end

function var_0_0._bodyActionDelay(arg_20_0)
	if arg_20_0._lastBodyActionName and arg_20_0._motionCutList[arg_20_0._lastBodyActionName] then
		arg_20_0:_setBodyAnimation(arg_20_0._bodyActionName, arg_20_0._actionLoop, arg_20_0._mixTime, true)
	else
		arg_20_0:setBodyAnimation(arg_20_0._bodyActionName, arg_20_0._actionLoop, arg_20_0._mixTime)
	end

	arg_20_0._lastBodyActionName = arg_20_0._bodyActionName
	arg_20_0._playBodyName = arg_20_0._bodyActionName
end

function var_0_0.checkBodyEnd(arg_21_0, arg_21_1)
	if arg_21_1 == arg_21_0._playBodyName and not arg_21_0._actionLoop then
		arg_21_0._bodyStart = arg_21_0._bodyStart + (Time.time - arg_21_0._bodyStartTime)

		arg_21_0:_playBodyAction()

		return true
	end
end

function var_0_0.removeTaskActions(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._bodyActionDelay, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._checkLoopActionEnd, arg_22_0)
end

function var_0_0.onVoiceStop(arg_23_0)
	arg_23_0._isVoiceStopping = true

	arg_23_0:removeTaskActions()
	arg_23_0:setNormal()

	arg_23_0._isVoiceStopping = false
end

return var_0_0
