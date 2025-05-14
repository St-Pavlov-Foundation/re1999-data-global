module("modules.logic.summon.comp.SummonDrawEquipComp", package.seeall)

local var_0_0 = class("SummonDrawEquipComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._rootGO = gohelper.findChild(arg_1_1, "anim")
	arg_1_0._goLed = gohelper.findChild(arg_1_1, "anim/StandStill/Obj-Plant/erjiguan")
	arg_1_0._tfLed = arg_1_0._goLed.transform
	arg_1_0._animLed = arg_1_0._goLed:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goLedOne = gohelper.findChild(arg_1_0._goLed, "diode_b")
	arg_1_0._goLedTen = gohelper.findChild(arg_1_0._goLed, "diode_a")
	arg_1_0._fadingFactor = 1
	arg_1_0._toZeroSpeed = 0.007
	arg_1_0._targetLedPosY = -1.51
	arg_1_0._finished = true
	arg_1_0._curProgress = 0

	arg_1_0:onCreate()
end

function var_0_0.onCreate(arg_2_0)
	return
end

function var_0_0.onUpdate(arg_3_0)
	if arg_3_0._finished then
		return
	end

	if arg_3_0._updateSpeed ~= 0 then
		arg_3_0._curProgress = arg_3_0._curProgress + arg_3_0._updateSpeed

		if arg_3_0._curProgress < 0 then
			arg_3_0._curProgress = 0
		elseif arg_3_0._curProgress > 1 then
			arg_3_0._curProgress = 1
		end

		arg_3_0:updateForEffect()
		arg_3_0:updateForSpeedFading()
		arg_3_0:updateForFinishCheck()
	end
end

function var_0_0.applySpeed(arg_4_0)
	local var_4_0 = -arg_4_0._deltaDistance * 0.003
	local var_4_1 = math.abs(var_4_0)
	local var_4_2 = var_4_0 / var_4_1
	local var_4_3 = 0.1

	return var_4_3 < var_4_1 and var_4_2 * var_4_3 or var_4_0
end

function var_0_0.updateForEffect(arg_5_0)
	local var_5_0 = arg_5_0._curProgress

	if arg_5_0._tfLed and arg_5_0._ledPosY then
		local var_5_1 = arg_5_0._ledPosY + (arg_5_0._targetLedPosY - arg_5_0._ledPosY) * var_5_0
		local var_5_2, var_5_3, var_5_4 = transformhelper.getLocalPos(arg_5_0._rootGO.transform)

		transformhelper.setLocalPos(arg_5_0._tfLed, var_5_2, var_5_1, var_5_4)
	end
end

function var_0_0.updateForSpeedFading(arg_6_0)
	if arg_6_0._updateSpeed < arg_6_0._toZeroSpeed then
		arg_6_0._updateSpeed = 0
	else
		arg_6_0._updateSpeed = arg_6_0._updateSpeed * arg_6_0._fadingFactor
	end
end

function var_0_0.updateForFinishCheck(arg_7_0)
	if arg_7_0._curProgress >= 1 then
		arg_7_0:_completeDraw()
	end
end

function var_0_0.resetDraw(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._rare = arg_8_1
	arg_8_0._curProgress = 0
	arg_8_0._updateSpeed = 0
	arg_8_0._deltaDistance = 0
	arg_8_0._finished = false
	arg_8_0._isTen = arg_8_2

	arg_8_0:updateForEffect()
	arg_8_0:resetLedFloat()
end

function var_0_0.skip(arg_9_0)
	arg_9_0._curProgress = 0
	arg_9_0._updateSpeed = 0
	arg_9_0._deltaDistance = 0
	arg_9_0._finished = false
end

function var_0_0.setEffect(arg_10_0, arg_10_1)
	arg_10_0._curProgress = math.min(math.max(1 - arg_10_1, 0), 1)

	arg_10_0:updateForEffect()
end

function var_0_0.resetLedFloat(arg_11_0)
	local var_11_0 = arg_11_0._isTen and arg_11_0._goLedTen or arg_11_0._goLedOne
	local var_11_1 = arg_11_0._isTen and arg_11_0._goLedOne or arg_11_0._goLedTen

	gohelper.setActive(var_11_0, false)
	gohelper.setActive(var_11_1, false)

	if not gohelper.isNil(arg_11_0._animLed) then
		arg_11_0._animLed.enabled = true
	end

	if not gohelper.isNil(arg_11_0._tfLed) then
		local var_11_2, var_11_3 = transformhelper.getLocalPos(arg_11_0._tfLed)

		arg_11_0._ledPosY = var_11_3
	end
end

function var_0_0.startDrag(arg_12_0)
	if not gohelper.isNil(arg_12_0._tfLed) then
		local var_12_0, var_12_1 = transformhelper.getLocalPos(arg_12_0._tfLed)

		arg_12_0._ledPosY = var_12_1
	end

	if not gohelper.isNil(arg_12_0._animLed) then
		arg_12_0._animLed.enabled = false
	end

	arg_12_0._fadingFactor = 0.1
end

function var_0_0.updateDistance(arg_13_0, arg_13_1)
	arg_13_0._deltaDistance = arg_13_1
	arg_13_0._updateSpeed = arg_13_0:applySpeed()
end

function var_0_0.endDrag(arg_14_0)
	arg_14_0._updateSpeed = 0.1
	arg_14_0._fadingFactor = 1.1
end

function var_0_0._completeDraw(arg_15_0)
	if arg_15_0._finished then
		return
	end

	arg_15_0._finished = true
	arg_15_0._updateSpeed = 0

	SummonController.instance:dispatchEvent(SummonEvent.onSummonDraw)
end

function var_0_0.onDestroy(arg_16_0)
	return
end

return var_0_0
