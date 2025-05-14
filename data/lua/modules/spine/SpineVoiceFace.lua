module("modules.spine.SpineVoiceFace", package.seeall)

local var_0_0 = class("SpineVoiceFace")
local var_0_1 = "_biyan"

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0:removeTaskActions()
	TaskDispatcher.cancelTask(arg_2_0._stopTransition, arg_2_0)

	arg_2_0._spineVoice = nil
	arg_2_0._voiceConfig = nil
	arg_2_0._spine = nil
end

function var_0_0.setFaceAnimation(arg_3_0, arg_3_1, arg_3_2)
	if string.find(arg_3_1, var_0_1) then
		arg_3_2 = false
	end

	arg_3_0._loop = arg_3_2

	TaskDispatcher.cancelTask(arg_3_0._nonLoopFaceEnd, arg_3_0)

	arg_3_0._lastFaceName = arg_3_1

	arg_3_0:_doSetFaceAnimation(arg_3_1, arg_3_2)
end

function var_0_0._doSetFaceAnimation(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= arg_4_0._spine:getCurFace() then
		local var_4_0 = arg_4_0._mixTime or 0.5

		if string.find(arg_4_1, var_0_1) then
			var_4_0 = 0.3
		end

		arg_4_0._spine:setFaceAnimation(arg_4_1, arg_4_2, var_4_0)
	end
end

function var_0_0.init(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._spineVoice = arg_5_1
	arg_5_0._voiceConfig = arg_5_2
	arg_5_0._spine = arg_5_3

	local var_5_0 = arg_5_0:getFace(arg_5_2)

	arg_5_0:playFaceActionList(var_5_0)
end

function var_0_0.getFace(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._spineVoice:getVoiceLang()

	if var_6_0 == "zh" then
		return arg_6_1.face
	else
		return arg_6_1[var_6_0 .. "face"] or arg_6_1.face
	end
end

function var_0_0._configValidity(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0 = #arg_7_1, 1, -1 do
		local var_7_0 = arg_7_1[iter_7_0]
		local var_7_1 = string.split(var_7_0, "#")
		local var_7_2 = true

		if #var_7_1 >= 3 then
			local var_7_3 = "e_" .. var_7_1[1]

			if arg_7_2:hasAnimation(var_7_3) then
				var_7_2 = false
			end
		end

		if var_7_2 then
			logError(string.format("id：%s 语音 face 无效的配置：%s face:%s", arg_7_0._voiceConfig.audio, var_7_0, arg_7_0:getFace(arg_7_0._voiceConfig)))
			table.remove(arg_7_1, iter_7_0)
		end
	end
end

function var_0_0.playFaceActionList(arg_8_0, arg_8_1)
	arg_8_0._faceStart = 0

	if not string.nilorempty(arg_8_1) then
		arg_8_0._faceList = string.split(arg_8_1, "|")

		arg_8_0:_configValidity(arg_8_0._faceList, arg_8_0._spine)
	else
		arg_8_0._faceList = {}
	end

	arg_8_0:_playFaceAction(arg_8_0._diffFaceBiYan)
end

function var_0_0._playFaceAction(arg_9_0, arg_9_1)
	arg_9_0._faceActionName = nil

	local var_9_0 = true

	arg_9_0:removeTaskActions()

	local var_9_1 = true

	if #arg_9_0._faceList > 0 then
		local var_9_2 = table.remove(arg_9_0._faceList, 1)
		local var_9_3 = string.split(var_9_2, "#")

		if #var_9_3 >= 3 then
			arg_9_0._faceActionName = "e_" .. var_9_3[1]

			local var_9_4 = tonumber(var_9_3[2])
			local var_9_5 = tonumber(var_9_3[3])

			arg_9_0._faceActionDuration = var_9_5 - var_9_4
			arg_9_0._mixTime = tonumber(var_9_3[4])
			arg_9_0._setLoop = var_9_3[5] == nil
			arg_9_0._delayTime = var_9_4 - arg_9_0._faceStart
			arg_9_0._faceStart = var_9_5
			arg_9_0._faceActionStartTime = Time.time

			if arg_9_0._delayTime > 0 then
				TaskDispatcher.runDelay(arg_9_0._faceActionDelay, arg_9_0, arg_9_0._delayTime)
			else
				var_9_0 = false

				arg_9_0:_faceActionDelay()
			end

			var_9_1 = false
		end
	end

	if var_9_0 then
		local var_9_6 = arg_9_0:_needBiYan(StoryAnimName.E_ZhengChang)

		arg_9_0:setNormal()

		if arg_9_1 then
			arg_9_0:setBiYan(var_9_6)
		end
	end

	if var_9_1 then
		arg_9_0:_onFaceEnd()
	end
end

function var_0_0._onFaceEnd(arg_10_0)
	arg_10_0._spineVoice:_onComponentStop(arg_10_0)
end

function var_0_0.setNormal(arg_11_0)
	arg_11_0:setFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

function var_0_0._faceActionDelay(arg_12_0)
	local var_12_0 = arg_12_0:_needBiYan(arg_12_0._faceActionName)

	arg_12_0:setFaceAnimation(arg_12_0._faceActionName, arg_12_0._setLoop)

	if not string.find(arg_12_0._faceActionName, var_0_1) then
		arg_12_0:setBiYan(var_12_0)
	end
end

function var_0_0.setBiYan(arg_13_0, arg_13_1)
	if not arg_13_0._spine then
		return
	end

	if arg_13_1 then
		arg_13_0._spine:setTransition(StoryAnimName.H_BiYan, false, 0)
	elseif arg_13_1 == false then
		arg_13_0._spine:setTransition(StoryAnimName.H_ZhengYan, false, 0)
	end

	TaskDispatcher.cancelTask(arg_13_0._stopTransition, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0._stopTransition, arg_13_0, 1)
end

function var_0_0._stopTransition(arg_14_0)
	arg_14_0._spine:stopTransition()
end

function var_0_0._needBiYan(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._diffFaceBiYan and arg_15_0._lastFaceName or arg_15_0._spine:getCurFace()
	local var_15_1 = var_15_0 and not string.find(var_15_0, var_0_1)

	if var_15_1 and arg_15_0._diffFaceBiYan then
		var_15_1 = arg_15_1 ~= arg_15_0._lastFaceName and true or nil
	end

	return var_15_1
end

function var_0_0.setDiffFaceBiYan(arg_16_0, arg_16_1)
	arg_16_0._diffFaceBiYan = arg_16_1
end

function var_0_0.checkFaceEnd(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0._faceActionName then
		local var_17_0 = arg_17_0._faceActionStartTime + arg_17_0._faceActionDuration + arg_17_0._delayTime
		local var_17_1 = Time.time

		if var_17_0 <= var_17_1 then
			arg_17_0:_playFaceAction(true)

			return true
		end

		if not arg_17_0._loop then
			local var_17_2 = var_17_0 - var_17_1

			TaskDispatcher.runDelay(arg_17_0._nonLoopFaceEnd, arg_17_0, var_17_2)
		end

		return true
	end
end

function var_0_0._nonLoopFaceEnd(arg_18_0)
	arg_18_0:_playFaceAction(true)
end

function var_0_0.removeTaskActions(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._faceActionDelay, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._nonLoopFaceEnd, arg_19_0)
end

function var_0_0.onVoiceStop(arg_20_0)
	arg_20_0:removeTaskActions()
	arg_20_0:_doSetFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

return var_0_0
