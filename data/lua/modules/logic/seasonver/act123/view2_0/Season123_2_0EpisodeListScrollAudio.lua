module("modules.logic.seasonver.act123.view2_0.Season123_2_0EpisodeListScrollAudio", package.seeall)

local var_0_0 = class("Season123_2_0EpisodeListScrollAudio", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.scroll = arg_1_1
	arg_1_0._contentWidth = recthelper.getHeight(arg_1_0.scroll.content)
	arg_1_0._intervalSampleOffset = 0.1
	arg_1_0._intervalSampleStop = 0.1
	arg_1_0._startPlayOffset = 0.81
	arg_1_0._startPlayOffsetDraging = 0.08
	arg_1_0._stopPlayOffset = 0.8
	arg_1_0._stopPlayOffsetDraging = 0.075
	arg_1_0._defaultSfxRepeatTime = 6
	arg_1_0._speedUpTweenTime = 2
	arg_1_0._pixelOffsetMoveFactor = 0.03
	arg_1_0._normalizeOffsetMoveFactor = 280
	arg_1_0._speedFactor = 0.7
	arg_1_0._scrollSfxDuration = arg_1_0._defaultSfxRepeatTime
	arg_1_0._isDraging = true
	arg_1_0._isDisposed = false
end

function var_0_0.onDragBegin(arg_2_0)
	arg_2_0._isDraging = true

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	arg_2_0:_resetPlayingStatus()
end

function var_0_0.onDragEnd(arg_3_0)
	arg_3_0:onUpdate()

	arg_3_0._isDraging = false
end

function var_0_0.onClickDown(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_start)
end

function var_0_0.onUpdate(arg_5_0)
	if arg_5_0.scroll and not arg_5_0._isDisposed then
		local var_5_0
		local var_5_1 = recthelper.getAnchorY(arg_5_0.scroll.content) * arg_5_0._pixelOffsetMoveFactor

		arg_5_0:_onValueChangeForStartOrStop(var_5_1)
		arg_5_0:_onValueChangeCheckReplay(var_5_1)
		arg_5_0:_onValueChangeSampleOffset(var_5_1)
	end
end

function var_0_0._onValueChangeSampleOffset(arg_6_0, arg_6_1)
	if arg_6_0._scrollAudioTime and arg_6_0._scrollSampleOffset then
		if Time.realtimeSinceStartup - arg_6_0._scrollAudioTime >= arg_6_0._intervalSampleOffset then
			arg_6_0:_onUpdateRTPCSpeed(arg_6_1)

			arg_6_0._scrollAudioTime = Time.realtimeSinceStartup
			arg_6_0._scrollSampleOffset = arg_6_1
		end
	else
		arg_6_0._scrollAudioTime = Time.realtimeSinceStartup
		arg_6_0._scrollSampleOffset = arg_6_1
	end
end

function var_0_0._onUpdateRTPCSpeed(arg_7_0, arg_7_1)
	local var_7_0 = math.abs(arg_7_1 - arg_7_0._scrollSampleOffset)

	arg_7_0._scrollSfxDuration = (arg_7_0._scrollSfxDuration + arg_7_0._defaultSfxRepeatTime + (var_7_0 - 0.5) * arg_7_0._speedUpTweenTime) * 0.5

	local var_7_1 = var_7_0 * arg_7_0._speedFactor

	if arg_7_0._lastRtpcValue == var_7_1 then
		return
	end

	arg_7_0._lastRtpcValue = var_7_1

	AudioMgr.instance:setRTPCValue(AudioEnum.UI.RTPC_ui_checkpoint_movespeed, arg_7_0._lastRtpcValue)
end

function var_0_0._onValueChangeForStartOrStop(arg_8_0, arg_8_1)
	if arg_8_0._scrollingPlayY and arg_8_0._scrollAudioStopTime then
		if Time.realtimeSinceStartup - arg_8_0._scrollAudioStopTime > arg_8_0._intervalSampleStop then
			local var_8_0 = math.abs(arg_8_1 - arg_8_0._scrollingPlayY)
			local var_8_1 = arg_8_0._startPlayOffset
			local var_8_2 = arg_8_0._stopPlayOffset

			if arg_8_0._isDraging then
				var_8_1 = arg_8_0._startPlayOffsetDraging
				var_8_2 = arg_8_0._stopPlayOffsetDraging
			end

			if var_8_1 <= var_8_0 and not arg_8_0._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
				arg_8_0:_onUpdateRTPCSpeed(arg_8_1)

				arg_8_0._scrollPlayingStartTime = Time.realtimeSinceStartup
				arg_8_0._isScrollPlaying = true
				arg_8_0._isFirstTimeDragPlay = false
			end

			if var_8_0 < var_8_2 and arg_8_0._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				arg_8_0:_resetPlayingStatus(arg_8_1)
			end

			arg_8_0._scrollingPlayY = arg_8_1
			arg_8_0._scrollAudioStopTime = Time.realtimeSinceStartup
		end
	else
		arg_8_0._scrollAudioStopTime = Time.realtimeSinceStartup
		arg_8_0._scrollingPlayY = arg_8_1
	end
end

function var_0_0._onValueChangeCheckReplay(arg_9_0, arg_9_1)
	if arg_9_0._isScrollPlaying and arg_9_0._scrollPlayingStartTime and arg_9_0._scrollSampleOffset and Time.realtimeSinceStartup - arg_9_0._scrollPlayingStartTime >= arg_9_0._scrollSfxDuration then
		arg_9_0:_resetPlayingStatus(arg_9_1)
	end
end

function var_0_0._resetPlayingStatus(arg_10_0, arg_10_1)
	arg_10_0._isScrollPlaying = false
	arg_10_0._scrollingPlayY = arg_10_1
end

function var_0_0.dispose(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)

	arg_11_0._isDisposed = true
	arg_11_0.scroll = nil
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0.scroll = nil
end

return var_0_0
