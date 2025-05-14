module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicBeatItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godynamics = gohelper.findChild(arg_1_0.viewGO, "root/#go_dynamics")
	arg_1_0._gostate1 = gohelper.findChild(arg_1_0.viewGO, "root/stateroot/#go_state1")
	arg_1_0._gostate2 = gohelper.findChild(arg_1_0.viewGO, "root/stateroot/#go_state2")
	arg_1_0._gostate3 = gohelper.findChild(arg_1_0.viewGO, "root/stateroot/#go_state3")
	arg_1_0._gostate4 = gohelper.findChild(arg_1_0.viewGO, "root/stateroot/#go_state4")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "root/#go_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._hideTime = VersionActivity2_4MusicBeatModel.instance:getHideTime()
	arg_4_0._scoreTimeList = VersionActivity2_4MusicBeatModel.instance:getScoreTimeList()
	arg_4_0._showTime = VersionActivity2_4MusicBeatModel.instance:getShowTime()
	arg_4_0._rootAnimator = arg_4_0.viewGO:GetComponent("Animator")
	arg_4_0._touchComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goclick, VersionActivity2_4MusicTouchComp, {
		callback = arg_4_0._onClickDown,
		callbackTarget = arg_4_0
	})
end

function var_0_0._onClickDown(arg_5_0)
	arg_5_0._clickDown = true
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	gohelper.setActive(arg_8_0.viewGO, true)
	gohelper.setActive(arg_8_0._gostate1, false)
	gohelper.setActive(arg_8_0._gostate2, false)
	gohelper.setActive(arg_8_0._gostate3, false)
	gohelper.setActive(arg_8_0._gostate4, false)
	transformhelper.setLocalScale(arg_8_0._godynamics.transform, 1, 1, 1)

	arg_8_0._config = arg_8_1
	arg_8_0._progressTime = arg_8_3
	arg_8_0.viewGO.name = tostring(arg_8_0._config.musicId)
	arg_8_0._clickDown = false
	arg_8_0._grade = nil
	arg_8_0._submitted = false

	local var_8_0 = Activity179Model.instance:getCalibration()

	arg_8_0._calibrationTime = arg_8_0._config.time - var_8_0
	arg_8_0._endTime = arg_8_0._calibrationTime + arg_8_0._hideTime
	arg_8_0._isTimeoutMiss = false
	arg_8_0._isPlayAudio = false
	arg_8_0._rootAnimator.speed = 1

	arg_8_0._touchComp:setTouchEnabled(true)

	if arg_8_2 then
		gohelper.addChild(arg_8_2, arg_8_0.viewGO)
	else
		logError("VersionActivity2_4MusicBeatItem parentGo is nil musicId:", tostring(arg_8_0._config.musicId))
	end
end

function var_0_0.pause(arg_9_0)
	arg_9_0._rootAnimator.speed = 0
end

function var_0_0.resume(arg_10_0)
	arg_10_0._rootAnimator.speed = 1
end

function var_0_0.disappear(arg_11_0, arg_11_1)
	if arg_11_1 >= arg_11_0._endTime then
		return true
	end
end

function var_0_0.timeout(arg_12_0, arg_12_1)
	if arg_12_1 >= arg_12_0._endTime then
		return true
	end
end

function var_0_0.setTimeoutMiss(arg_13_0)
	if arg_13_0._grade then
		return
	end

	arg_13_0:_setGrade(VersionActivity2_4MusicEnum.BeatGrade.Miss)

	arg_13_0._endTime = arg_13_0._endTime + 0.5
	arg_13_0._isTimeoutMiss = true
end

function var_0_0.setMiss(arg_14_0)
	if arg_14_0._grade then
		return
	end

	arg_14_0:_setGrade(VersionActivity2_4MusicEnum.BeatGrade.Miss)
end

function var_0_0.updateFrame(arg_15_0, arg_15_1)
	arg_15_0:_checkGrade(arg_15_1)
	arg_15_0:_playAnim(arg_15_1)
end

function var_0_0._playAnim(arg_16_0, arg_16_1)
	if arg_16_0._isTimeoutMiss then
		local var_16_0 = 0

		transformhelper.setLocalScale(arg_16_0._godynamics.transform, var_16_0, var_16_0, 1)

		return
	end

	if arg_16_0._isPlayAudio == false and arg_16_1 >= arg_16_0._calibrationTime then
		arg_16_0._isPlayAudio = true
	end

	local var_16_1 = arg_16_0._calibrationTime
	local var_16_2 = arg_16_0._calibrationTime + arg_16_0._showTime
	local var_16_3 = arg_16_0._endTime
	local var_16_4 = arg_16_1 <= var_16_1
	local var_16_5 = var_16_4 and var_16_2 or var_16_1
	local var_16_6 = var_16_4 and var_16_1 or var_16_3
	local var_16_7 = (arg_16_1 - var_16_5) / (var_16_6 - var_16_5)
	local var_16_8 = var_16_4 and 1 or 0.35
	local var_16_9 = var_16_8 - (var_16_8 - (var_16_4 and 0.35 or 0)) * var_16_7

	transformhelper.setLocalScale(arg_16_0._godynamics.transform, var_16_9, var_16_9, 1)
end

function var_0_0._checkGrade(arg_17_0, arg_17_1)
	if not arg_17_0._clickDown then
		return
	end

	arg_17_0._clickDown = false

	if not arg_17_0._grade then
		arg_17_0:_setGrade(arg_17_0:_getGrade(arg_17_1))

		if arg_17_0._grade then
			AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_perfect)
		end
	end
end

function var_0_0._setGrade(arg_18_0, arg_18_1)
	if arg_18_0._submitted then
		return
	end

	arg_18_0._grade = arg_18_1

	gohelper.setActive(arg_18_0["_gostate" .. arg_18_0._grade], true)
	arg_18_0._touchComp:setTouchEnabled(false)
end

function var_0_0.setSubmit(arg_19_0)
	arg_19_0._submitted = true
end

function var_0_0.isSubmitted(arg_20_0)
	return arg_20_0._submitted
end

function var_0_0.getGrade(arg_21_0)
	return arg_21_0._grade
end

function var_0_0._getGrade(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._scoreTimeList) do
		local var_22_0 = arg_22_0._calibrationTime + iter_22_1[1]
		local var_22_1 = arg_22_0._calibrationTime + iter_22_1[2]

		if var_22_0 <= arg_22_1 and arg_22_1 <= var_22_1 then
			return iter_22_0
		end
	end

	return VersionActivity2_4MusicEnum.BeatGrade.Cool
end

function var_0_0.hide(arg_23_0)
	gohelper.setActive(arg_23_0.viewGO, false)
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
