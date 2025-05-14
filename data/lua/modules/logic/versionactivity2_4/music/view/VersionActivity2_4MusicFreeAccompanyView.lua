module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeAccompanyView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeAccompanyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "root/#go_time")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/#go_time/valuebg/#input_value")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_time/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_time/#btn_add")
	arg_1_0._godynamics = gohelper.findChild(arg_1_0.viewGO, "root/centercir/#go_dynamics")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "root/centercir/#go_center")
	arg_1_0._gostate = gohelper.findChild(arg_1_0.viewGO, "root/centercir/#go_state")
	arg_1_0._gostate1 = gohelper.findChild(arg_1_0.viewGO, "root/centercir/#go_state/#go_state1")
	arg_1_0._gostate2 = gohelper.findChild(arg_1_0.viewGO, "root/centercir/#go_state/#go_state2")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/centercir/#btn_click")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._audioStartScale then
		return
	end

	local var_4_0 = (arg_4_0._audioStartScale - arg_4_0._dynamicScale) * arg_4_0._time * 1000

	arg_4_0._curValue = math.ceil(var_4_0)

	if arg_4_0._curValue < 0 then
		arg_4_0._curValue = 0
	end

	arg_4_0._audioStartScale = nil

	arg_4_0:_checkLimit()
end

function var_0_0._btnsubOnClick(arg_5_0)
	arg_5_0._curValue = arg_5_0._curValue - arg_5_0._stepValue

	arg_5_0:_checkLimit()
end

function var_0_0._btnaddOnClick(arg_6_0)
	arg_6_0._curValue = arg_6_0._curValue + arg_6_0._stepValue

	arg_6_0:_checkLimit()
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._minValue = 0
	arg_11_0._maxValue = 2000
	arg_11_0._stepValue = 1
	arg_11_0._curValue = Activity179Model.instance:getCalibration() * 1000
	arg_11_0._time = 2
	arg_11_0._audioId = 20240027
	arg_11_0._centerScale = 3
	arg_11_0._startScale = 1
	arg_11_0._endScale = 0
	arg_11_0._audioScale = 0.75
	arg_11_0._audioOffsetTime = (arg_11_0._startScale - arg_11_0._audioScale) * arg_11_0._time * 1000

	arg_11_0:_checkLimit()
	arg_11_0._inputvalue:AddOnEndEdit(arg_11_0._onEndEdit, arg_11_0)
	arg_11_0:_startCalibration()
end

function var_0_0._updateInputValue(arg_12_0)
	arg_12_0._inputvalue:SetText(arg_12_0._curValue)
end

function var_0_0._onEndEdit(arg_13_0)
	arg_13_0._curValue = tonumber(arg_13_0._inputvalue:GetText()) or 0

	arg_13_0:_checkLimit()
end

function var_0_0._checkLimit(arg_14_0)
	arg_14_0._curValue = math.max(arg_14_0._minValue, math.min(arg_14_0._maxValue, arg_14_0._curValue))

	Activity179Model.instance:setCalibration(arg_14_0._curValue)

	local var_14_0 = arg_14_0._curValue + arg_14_0._audioOffsetTime

	arg_14_0:_updateInputValue()

	local var_14_1 = (arg_14_0._maxValue - var_14_0) / arg_14_0._maxValue * arg_14_0._centerScale

	transformhelper.setLocalScale(arg_14_0._gocenter.transform, var_14_1, var_14_1, var_14_1)
end

function var_0_0._startCalibration(arg_15_0)
	if arg_15_0._tweenId then
		ZProj.TweenHelper.KillById(arg_15_0._tweenId)

		arg_15_0._tweenId = nil
	end

	arg_15_0._audioStartScale = nil
	arg_15_0._dynamicScale = arg_15_0._startScale
	arg_15_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_15_0._startScale, arg_15_0._endScale, arg_15_0._time, arg_15_0._frameCallback, arg_15_0._tweenFinish, arg_15_0)
end

function var_0_0._frameCallback(arg_16_0, arg_16_1)
	if arg_16_0._dynamicScale >= arg_16_0._audioScale and arg_16_1 <= arg_16_0._audioScale then
		AudioMgr.instance:trigger(arg_16_0._audioId)

		arg_16_0._audioStartScale = arg_16_1
	end

	arg_16_0._dynamicScale = arg_16_1

	transformhelper.setLocalScale(arg_16_0._godynamics.transform, arg_16_1, arg_16_1, arg_16_1)
end

function var_0_0._tweenFinish(arg_17_0)
	arg_17_0:_startCalibration()
end

function var_0_0.onClose(arg_18_0)
	arg_18_0._inputvalue:RemoveOnEndEdit()

	if arg_18_0._tweenId then
		ZProj.TweenHelper.KillById(arg_18_0._tweenId)

		arg_18_0._tweenId = nil
	end
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
