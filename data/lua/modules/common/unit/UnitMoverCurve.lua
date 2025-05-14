module("modules.common.unit.UnitMoverCurve", package.seeall)

local var_0_0 = class("UnitMoverCurve", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._timeScale = 1
	arg_1_0._currTime = 0
	arg_1_0._duration = 0
	arg_1_0._wayPointBegin = nil
	arg_1_0._wayPointEnd = nil
	arg_1_0._wayPointValue = nil
	arg_1_0._animationCurve = nil
	arg_1_0._tCurve = nil
	arg_1_0._getTimeFunction = nil
	arg_1_0._getTimeObject = nil
	arg_1_0._x_move_curve = nil
	arg_1_0._y_move_curve = nil
	arg_1_0._z_move_curve = nil

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.setCurveParam(arg_2_0, arg_2_1)
	arg_2_0._animationCurve = ZProj.AnimationCurveHelper.GetAnimationCurve(arg_2_1)

	if not arg_2_0._animationCurve then
		logError("动画曲线参数错误")
	end
end

function var_0_0.setTCurveParam(arg_3_0, arg_3_1)
	arg_3_0._tCurve = nil

	if not string.nilorempty(arg_3_1) then
		arg_3_0._tCurve = ZProj.AnimationCurveHelper.GetAnimationCurve(arg_3_1)
	end
end

function var_0_0.setEaseType(arg_4_0, arg_4_1)
	arg_4_0._easeType = arg_4_1 or EaseType.Linear
end

function var_0_0.setTimeScale(arg_5_0, arg_5_1)
	arg_5_0._timeScale = arg_5_1
end

function var_0_0.simpleMove(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	arg_6_0:setPosDirectly(arg_6_1, arg_6_2, arg_6_3)

	arg_6_0._currTime = 0
	arg_6_0._duration = arg_6_7
	arg_6_0._wayPointBegin = {
		x = arg_6_1,
		y = arg_6_2,
		z = arg_6_3
	}
	arg_6_0._wayPointEnd = {
		x = arg_6_4,
		y = arg_6_5,
		z = arg_6_6
	}
	arg_6_0._wayPointValue = {
		x = arg_6_4 - arg_6_1,
		y = arg_6_5 - arg_6_2,
		z = arg_6_6 - arg_6_3
	}
end

function var_0_0.setPosDirectly(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._wayPointBegin = nil
	arg_7_0._wayPointValue = nil
	arg_7_0._yOffset = nil
	arg_7_0._posX = arg_7_1
	arg_7_0._posY = arg_7_2
	arg_7_0._posZ = arg_7_3

	arg_7_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_7_0)
end

function var_0_0.setGetTimeFunction(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._getTimeFunction = arg_8_1
	arg_8_0._getTimeObject = arg_8_2
end

function var_0_0.getCurWayPoint(arg_9_0)
	return arg_9_0._curWayPoint
end

function var_0_0.getPos(arg_10_0)
	return arg_10_0._posX, arg_10_0._posY + (arg_10_0._yOffset or 0), arg_10_0._posZ
end

function var_0_0.onUpdate(arg_11_0)
	if not arg_11_0._wayPointBegin then
		return
	end

	if arg_11_0._getTimeFunction then
		arg_11_0._currTime = arg_11_0._getTimeFunction(arg_11_0._getTimeObject)
	else
		arg_11_0._currTime = arg_11_0._currTime + Time.deltaTime * arg_11_0._timeScale
	end

	if arg_11_0._currTime >= arg_11_0._duration then
		arg_11_0._posX = arg_11_0._wayPointEnd.x
		arg_11_0._posY = arg_11_0._wayPointEnd.y
		arg_11_0._posZ = arg_11_0._wayPointEnd.z
		arg_11_0._wayPointBegin = nil
		arg_11_0._wayPointEnd = nil
		arg_11_0._wayPointValue = nil

		arg_11_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_11_0)
		arg_11_0:dispatchEvent(UnitMoveEvent.Arrive, arg_11_0)
	else
		local var_11_0 = arg_11_0._currTime / arg_11_0._duration
		local var_11_1 = LuaTween.tween(var_11_0, 0, 1, 1, arg_11_0._easeType)

		if arg_11_0._animationCurve then
			arg_11_0._yOffset = arg_11_0._animationCurve:Evaluate(var_11_1)
		end

		if arg_11_0._tCurve then
			local var_11_2 = arg_11_0._tCurve:Evaluate(var_11_1) / 10

			arg_11_0._posX = arg_11_0._wayPointBegin.x * (1 - var_11_2) + arg_11_0._wayPointEnd.x * var_11_2
			arg_11_0._posY = arg_11_0._wayPointBegin.y * (1 - var_11_2) + arg_11_0._wayPointEnd.y * var_11_2
			arg_11_0._posZ = arg_11_0._wayPointBegin.z * (1 - var_11_2) + arg_11_0._wayPointEnd.z * var_11_2
		else
			if arg_11_0._x_move_curve then
				arg_11_0._posX = arg_11_0._wayPointBegin.x + (arg_11_0._wayPointEnd.x - arg_11_0._wayPointBegin.x) * arg_11_0._x_move_curve:Evaluate(var_11_1) / 10
			else
				arg_11_0._posX = LuaTween.tween(arg_11_0._currTime, arg_11_0._wayPointBegin.x, arg_11_0._wayPointValue.x, arg_11_0._duration, arg_11_0._easeType)
			end

			if arg_11_0._y_move_curve then
				arg_11_0._posY = arg_11_0._wayPointBegin.y + (arg_11_0._wayPointEnd.y - arg_11_0._wayPointBegin.y) * arg_11_0._y_move_curve:Evaluate(var_11_1) / 10
			else
				arg_11_0._posY = LuaTween.tween(arg_11_0._currTime, arg_11_0._wayPointBegin.y, arg_11_0._wayPointValue.y, arg_11_0._duration, arg_11_0._easeType)
			end

			if arg_11_0._z_move_curve then
				arg_11_0._posZ = arg_11_0._wayPointBegin.z + (arg_11_0._wayPointEnd.z - arg_11_0._wayPointBegin.z) * arg_11_0._z_move_curve:Evaluate(var_11_1) / 10
			else
				arg_11_0._posZ = LuaTween.tween(arg_11_0._currTime, arg_11_0._wayPointBegin.z, arg_11_0._wayPointValue.z, arg_11_0._duration, arg_11_0._easeType)
			end
		end

		arg_11_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_11_0)
	end
end

function var_0_0.setXMoveCruve(arg_12_0, arg_12_1)
	if string.nilorempty(arg_12_1) then
		return
	end

	arg_12_0._x_move_curve = ZProj.AnimationCurveHelper.GetAnimationCurve(arg_12_1)

	if not arg_12_0._x_move_curve then
		logError("X轴位移曲线参数错误")
	end
end

function var_0_0.setYMoveCruve(arg_13_0, arg_13_1)
	if string.nilorempty(arg_13_1) then
		return
	end

	arg_13_0._y_move_curve = ZProj.AnimationCurveHelper.GetAnimationCurve(arg_13_1)

	if not arg_13_0._y_move_curve then
		logError("Y轴位移曲线参数错误")
	end
end

function var_0_0.setZMoveCruve(arg_14_0, arg_14_1)
	if string.nilorempty(arg_14_1) then
		return
	end

	arg_14_0._z_move_curve = ZProj.AnimationCurveHelper.GetAnimationCurve(arg_14_1)

	if not arg_14_0._z_move_curve then
		logError("Z轴位移曲线参数错误")
	end
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0._animationCurve = nil
	arg_15_0._tCurve = nil
	arg_15_0._x_move_curve = nil
	arg_15_0._y_move_curve = nil
	arg_15_0._z_move_curve = nil
	arg_15_0._yOffset = nil
end

return var_0_0
