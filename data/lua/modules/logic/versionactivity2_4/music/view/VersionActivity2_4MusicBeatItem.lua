module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatItem", package.seeall)

slot0 = class("VersionActivity2_4MusicBeatItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._godynamics = gohelper.findChild(slot0.viewGO, "root/#go_dynamics")
	slot0._gostate1 = gohelper.findChild(slot0.viewGO, "root/stateroot/#go_state1")
	slot0._gostate2 = gohelper.findChild(slot0.viewGO, "root/stateroot/#go_state2")
	slot0._gostate3 = gohelper.findChild(slot0.viewGO, "root/stateroot/#go_state3")
	slot0._gostate4 = gohelper.findChild(slot0.viewGO, "root/stateroot/#go_state4")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "root/#go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._hideTime = VersionActivity2_4MusicBeatModel.instance:getHideTime()
	slot0._scoreTimeList = VersionActivity2_4MusicBeatModel.instance:getScoreTimeList()
	slot0._showTime = VersionActivity2_4MusicBeatModel.instance:getShowTime()
	slot0._rootAnimator = slot0.viewGO:GetComponent("Animator")
	slot0._touchComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goclick, VersionActivity2_4MusicTouchComp, {
		callback = slot0._onClickDown,
		callbackTarget = slot0
	})
end

function slot0._onClickDown(slot0)
	slot0._clickDown = true
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0.viewGO, true)
	gohelper.setActive(slot0._gostate1, false)
	gohelper.setActive(slot0._gostate2, false)
	gohelper.setActive(slot0._gostate3, false)
	gohelper.setActive(slot0._gostate4, false)
	transformhelper.setLocalScale(slot0._godynamics.transform, 1, 1, 1)

	slot0._config = slot1
	slot0._progressTime = slot3
	slot0.viewGO.name = tostring(slot0._config.musicId)
	slot0._clickDown = false
	slot0._grade = nil
	slot0._submitted = false
	slot0._calibrationTime = slot0._config.time - Activity179Model.instance:getCalibration()
	slot0._endTime = slot0._calibrationTime + slot0._hideTime
	slot0._isTimeoutMiss = false
	slot0._isPlayAudio = false
	slot0._rootAnimator.speed = 1

	slot0._touchComp:setTouchEnabled(true)

	if slot2 then
		gohelper.addChild(slot2, slot0.viewGO)
	else
		logError("VersionActivity2_4MusicBeatItem parentGo is nil musicId:", tostring(slot0._config.musicId))
	end
end

function slot0.pause(slot0)
	slot0._rootAnimator.speed = 0
end

function slot0.resume(slot0)
	slot0._rootAnimator.speed = 1
end

function slot0.disappear(slot0, slot1)
	if slot0._endTime <= slot1 then
		return true
	end
end

function slot0.timeout(slot0, slot1)
	if slot0._endTime <= slot1 then
		return true
	end
end

function slot0.setTimeoutMiss(slot0)
	if slot0._grade then
		return
	end

	slot0:_setGrade(VersionActivity2_4MusicEnum.BeatGrade.Miss)

	slot0._endTime = slot0._endTime + 0.5
	slot0._isTimeoutMiss = true
end

function slot0.setMiss(slot0)
	if slot0._grade then
		return
	end

	slot0:_setGrade(VersionActivity2_4MusicEnum.BeatGrade.Miss)
end

function slot0.updateFrame(slot0, slot1)
	slot0:_checkGrade(slot1)
	slot0:_playAnim(slot1)
end

function slot0._playAnim(slot0, slot1)
	if slot0._isTimeoutMiss then
		slot2 = 0

		transformhelper.setLocalScale(slot0._godynamics.transform, slot2, slot2, 1)

		return
	end

	if slot0._isPlayAudio == false and slot0._calibrationTime <= slot1 then
		slot0._isPlayAudio = true
	end

	slot5 = slot1 <= slot0._calibrationTime
	slot6 = slot5 and slot0._calibrationTime + slot0._showTime or slot2
	slot11 = slot5 and 1 or 0.35
	slot14 = slot11 - (slot11 - (slot5 and 0.35 or 0)) * (slot1 - slot6) / ((slot5 and slot2 or slot0._endTime) - slot6)

	transformhelper.setLocalScale(slot0._godynamics.transform, slot14, slot14, 1)
end

function slot0._checkGrade(slot0, slot1)
	if not slot0._clickDown then
		return
	end

	slot0._clickDown = false

	if not slot0._grade then
		slot0:_setGrade(slot0:_getGrade(slot1))

		if slot0._grade then
			AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_perfect)
		end
	end
end

function slot0._setGrade(slot0, slot1)
	if slot0._submitted then
		return
	end

	slot0._grade = slot1

	gohelper.setActive(slot0["_gostate" .. slot0._grade], true)
	slot0._touchComp:setTouchEnabled(false)
end

function slot0.setSubmit(slot0)
	slot0._submitted = true
end

function slot0.isSubmitted(slot0)
	return slot0._submitted
end

function slot0.getGrade(slot0)
	return slot0._grade
end

function slot0._getGrade(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._scoreTimeList) do
		if slot0._calibrationTime + slot6[1] <= slot1 and slot1 <= slot0._calibrationTime + slot6[2] then
			return slot5
		end
	end

	return VersionActivity2_4MusicEnum.BeatGrade.Cool
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0.onDestroyView(slot0)
end

return slot0
