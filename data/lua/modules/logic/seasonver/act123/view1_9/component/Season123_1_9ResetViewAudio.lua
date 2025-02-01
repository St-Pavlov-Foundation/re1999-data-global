module("modules.logic.seasonver.act123.view1_9.component.Season123_1_9ResetViewAudio", package.seeall)

slot0 = class("Season123_1_9ResetViewAudio", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.scroll = slot1

	if slot0.scroll.content then
		slot0._contentWidth = recthelper.getWidth(slot0.scroll.content)
	else
		slot0._contentWidth = recthelper.getWidth(slot0.scroll.transform)
	end

	slot0._intervalSampleOffset = 0.1
	slot0._intervalSampleStop = 0.1
	slot0._startPlayOffset = 0.81
	slot0._startPlayOffsetDraging = 0.08
	slot0._stopPlayOffset = 0.8
	slot0._stopPlayOffsetDraging = 0.075
	slot0._defaultSfxRepeatTime = 6
	slot0._speedUpTweenTime = 2
	slot0._pixelOffsetMoveFactor = 0.03
	slot0._normalizeOffsetMoveFactor = 280
	slot0._speedFactor = 0.7
	slot0._scrollSfxDuration = slot0._defaultSfxRepeatTime
	slot0._isDraging = true
	slot0._isDisposed = false
end

function slot0.onDragBegin(slot0)
	slot0._isDraging = true

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	slot0:_resetPlayingStatus()
end

function slot0.onDragEnd(slot0)
	slot0:onUpdate()

	slot0._isDraging = false
end

function slot0.onClickDown(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_start)
end

function slot0.onUpdate(slot0)
	if slot0.scroll and not slot0._isDisposed then
		slot1 = nil
		slot1 = recthelper.getAnchorX(slot0.scroll.content) * slot0._pixelOffsetMoveFactor

		slot0:_onValueChangeForStartOrStop(slot1)
		slot0:_onValueChangeCheckReplay(slot1)
		slot0:_onValueChangeSampleOffset(slot1)
	end
end

function slot0._onValueChangeSampleOffset(slot0, slot1)
	if slot0._scrollAudioTime and slot0._scrollSampleOffset then
		if slot0._intervalSampleOffset <= Time.realtimeSinceStartup - slot0._scrollAudioTime then
			slot0:_onUpdateRTPCSpeed(slot1)

			slot0._scrollAudioTime = Time.realtimeSinceStartup
			slot0._scrollSampleOffset = slot1
		end
	else
		slot0._scrollAudioTime = Time.realtimeSinceStartup
		slot0._scrollSampleOffset = slot1
	end
end

function slot0._onUpdateRTPCSpeed(slot0, slot1)
	slot2 = math.abs(slot1 - slot0._scrollSampleOffset)
	slot0._scrollSfxDuration = (slot0._scrollSfxDuration + slot0._defaultSfxRepeatTime + (slot2 - 0.5) * slot0._speedUpTweenTime) * 0.5

	if slot0._lastRtpcValue == slot2 * slot0._speedFactor then
		return
	end

	slot0._lastRtpcValue = slot3

	AudioMgr.instance:setRTPCValue(AudioEnum.UI.RTPC_ui_checkpoint_movespeed, slot0._lastRtpcValue)
end

function slot0._onValueChangeForStartOrStop(slot0, slot1)
	if slot0._scrollingPlayX and slot0._scrollAudioStopTime then
		if slot0._intervalSampleStop < Time.realtimeSinceStartup - slot0._scrollAudioStopTime then
			slot3 = math.abs(slot1 - slot0._scrollingPlayX)
			slot4 = slot0._startPlayOffset
			slot5 = slot0._stopPlayOffset

			if slot0._isDraging then
				slot4 = slot0._startPlayOffsetDraging
				slot5 = slot0._stopPlayOffsetDraging
			end

			if slot4 <= slot3 and not slot0._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
				slot0:_onUpdateRTPCSpeed(slot1)

				slot0._scrollPlayingStartTime = Time.realtimeSinceStartup
				slot0._isScrollPlaying = true
				slot0._isFirstTimeDragPlay = false
			end

			if slot3 < slot5 and slot0._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				slot0:_resetPlayingStatus(slot1)
			end

			slot0._scrollingPlayX = slot1
			slot0._scrollAudioStopTime = Time.realtimeSinceStartup
		end
	else
		slot0._scrollAudioStopTime = Time.realtimeSinceStartup
		slot0._scrollingPlayX = slot1
	end
end

function slot0._onValueChangeCheckReplay(slot0, slot1)
	if slot0._isScrollPlaying and slot0._scrollPlayingStartTime and slot0._scrollSampleOffset and slot0._scrollSfxDuration <= Time.realtimeSinceStartup - slot0._scrollPlayingStartTime then
		slot0:_resetPlayingStatus(slot1)
	end
end

function slot0._resetPlayingStatus(slot0, slot1)
	slot0._isScrollPlaying = false
	slot0._scrollingPlayX = slot1
end

function slot0.dispose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)

	slot0._isDisposed = true
	slot0.scroll = nil
end

function slot0.onDestroy(slot0)
	slot0.scroll = nil
end

return slot0
