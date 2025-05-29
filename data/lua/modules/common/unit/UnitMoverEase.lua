module("modules.common.unit.UnitMoverEase", package.seeall)

local var_0_0 = class("UnitMoverEase", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._timeScale = 1
	arg_1_0._currTime = 0
	arg_1_0._duration = 0
	arg_1_0._wayPointBegin = nil
	arg_1_0._wayPointEnd = nil
	arg_1_0._wayPointValue = nil
	arg_1_0._easeType = EaseType.Linear
	arg_1_0._getTimeFunction = nil
	arg_1_0._getTimeObject = nil

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.setEaseType(arg_2_0, arg_2_1)
	arg_2_0._easeType = arg_2_1
end

function var_0_0.setTimeScale(arg_3_0, arg_3_1)
	arg_3_0._timeScale = arg_3_1
end

function var_0_0.simpleMove(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	arg_4_0:setPosDirectly(arg_4_1, arg_4_2, arg_4_3)

	arg_4_0._currTime = 0
	arg_4_0._duration = arg_4_7
	arg_4_0._wayPointBegin = {
		x = arg_4_1,
		y = arg_4_2,
		z = arg_4_3
	}
	arg_4_0._wayPointEnd = {
		x = arg_4_4,
		y = arg_4_5,
		z = arg_4_6
	}
	arg_4_0._wayPointValue = {
		x = arg_4_4 - arg_4_1,
		y = arg_4_5 - arg_4_2,
		z = arg_4_6 - arg_4_3
	}
	arg_4_0._lastStartPos = arg_4_0._wayPointBegin
	arg_4_0._lastEndPos = arg_4_0._wayPointEnd
end

function var_0_0.getLastStartPos(arg_5_0)
	return arg_5_0._lastStartPos
end

function var_0_0.getLastEndPos(arg_6_0)
	return arg_6_0._lastEndPos
end

function var_0_0.setPosDirectly(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._wayPointBegin = nil
	arg_7_0._wayPointValue = nil
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
	return arg_10_0._posX, arg_10_0._posY, arg_10_0._posZ
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
		arg_11_0._posX = LuaTween.tween(arg_11_0._currTime, arg_11_0._wayPointBegin.x, arg_11_0._wayPointValue.x, arg_11_0._duration, arg_11_0._easeType)
		arg_11_0._posY = LuaTween.tween(arg_11_0._currTime, arg_11_0._wayPointBegin.y, arg_11_0._wayPointValue.y, arg_11_0._duration, arg_11_0._easeType)
		arg_11_0._posZ = LuaTween.tween(arg_11_0._currTime, arg_11_0._wayPointBegin.z, arg_11_0._wayPointValue.z, arg_11_0._duration, arg_11_0._easeType)

		arg_11_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_11_0)
	end
end

return var_0_0
