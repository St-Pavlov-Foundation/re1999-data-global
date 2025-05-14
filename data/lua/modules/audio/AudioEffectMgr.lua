module("modules.audio.AudioEffectMgr", package.seeall)

local var_0_0 = class("AudioEffectMgr")

var_0_0.OnPlayAudio = 101

function var_0_0.ctor(arg_1_0)
	arg_1_0._pool = AudioItem.createPool()
	arg_1_0._playingList = {}

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.setVolume(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0._playingList[arg_2_1]

	if not var_2_0 then
		return
	end

	var_2_0:setVolume(arg_2_2, arg_2_3)
end

function var_0_0.setSwitch(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0._playingList[arg_3_1]

	if not var_3_0 then
		return
	end

	var_3_0:setSwitch(arg_3_2, arg_3_3)
end

function var_0_0.playAudio(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0._playingList[arg_4_1] then
		return
	end

	arg_4_2 = arg_4_2 or arg_4_0:_getDefaultAudioParam()
	arg_4_2.audioLang = arg_4_3

	local var_4_0 = arg_4_0._pool:getObject()

	arg_4_0._playingList[arg_4_1] = var_4_0

	var_4_0:playAudio(arg_4_1, arg_4_2)
	arg_4_0:dispatchEvent(var_0_0.OnPlayAudio, arg_4_1, var_4_0)
end

function var_0_0._getDefaultAudioParam(arg_5_0)
	arg_5_0._defaultAudioParam = arg_5_0._defaultAudioParam or AudioParam.New()

	arg_5_0._defaultAudioParam:clear()

	arg_5_0._defaultAudioParam.loopNum = 1
	arg_5_0._defaultAudioParam.fadeInTime = 0
	arg_5_0._defaultAudioParam.fadeOutTime = 0

	return arg_5_0._defaultAudioParam
end

function var_0_0.seekPercent(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._playingList[arg_6_1]

	if not var_6_0 then
		var_6_0:seekPercent(arg_6_2)
	end
end

function var_0_0.seekMilliSeconds(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._playingList[arg_7_1]

	if var_7_0 then
		var_7_0:seekMilliSeconds(arg_7_2)
	end
end

function var_0_0.stopAudio(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._playingList[arg_8_1] then
		return
	end

	arg_8_0._playingList[arg_8_1]:stopAudio(arg_8_1, arg_8_2)
end

function var_0_0.removePlayingAudio(arg_9_0, arg_9_1)
	arg_9_0._playingList[arg_9_1] = nil
end

function var_0_0.isPlaying(arg_10_0, arg_10_1)
	return arg_10_0._playingList[arg_10_1]
end

function var_0_0.getPlayingItemDict(arg_11_0)
	return arg_11_0._playingList
end

function var_0_0.playAudioByEffectPath(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = AudioConfig.instance:getAudioConfig(arg_12_1)

	if var_12_0 then
		local var_12_1 = arg_12_0:_getEffectAudioParam(arg_12_2, arg_12_3)

		arg_12_0:playAudio(var_12_0.audioId, var_12_1)

		return var_12_0.audioId
	end
end

function var_0_0._getEffectAudioParam(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._effectAudioParam = arg_13_0._effectAudioParam or AudioParam.New()

	arg_13_0._effectAudioParam:clear()

	arg_13_0._effectAudioParam.loopNum = 1
	arg_13_0._effectAudioParam.fadeInTime = arg_13_1
	arg_13_0._effectAudioParam.fadeOutTime = arg_13_2

	return arg_13_0._effectAudioParam
end

function var_0_0.stopAudioByEffectPath(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = AudioConfig.instance:getAudioConfig(arg_14_1)

	if var_14_0 then
		arg_14_0:stopAudio(var_14_0.audioId, arg_14_2)
	end
end

function var_0_0._onStopAudio(arg_15_0, arg_15_1)
	if not arg_15_0._playingList[arg_15_1] then
		return
	end

	local var_15_0 = arg_15_0._playingList[arg_15_1]

	arg_15_0._pool:putObject(var_15_0)

	arg_15_0._playingList[arg_15_1] = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
