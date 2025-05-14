module("modules.common.unit.UnitMoverBezier", package.seeall)

local var_0_0 = class("UnitMoverBezier", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._timeScale = 1
	arg_1_0._currTime = 0
	arg_1_0._duration = 0
	arg_1_0._wayPointBegin = nil
	arg_1_0._wayPointEnd = nil
	arg_1_0._wayPointValue = nil
	arg_1_0._animationCurve = nil
	arg_1_0._getTimeFunction = nil
	arg_1_0._getTimeObject = nil

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.setBezierParam(arg_2_0, arg_2_1)
	if not string.nilorempty(arg_2_1) then
		local var_2_0 = FightStrUtil.instance:getSplitToNumberCache(arg_2_1, "#")

		if var_2_0 and #var_2_0 >= 2 then
			arg_2_0._bezierX = tonumber(var_2_0[1]) or 0.5
			arg_2_0._bezierY = tonumber(var_2_0[2]) or 0
		end
	end
end

function var_0_0.setEaseType(arg_3_0, arg_3_1)
	arg_3_0._easeType = arg_3_1 or EaseType.Linear
end

function var_0_0.setTimeScale(arg_4_0, arg_4_1)
	arg_4_0._timeScale = arg_4_1
end

function var_0_0.simpleMove(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	arg_5_0:setPosDirectly(arg_5_1, arg_5_2, arg_5_3)

	arg_5_0._currTime = 0
	arg_5_0._duration = arg_5_7
	arg_5_0._wayPointBegin = {
		x = arg_5_1,
		y = arg_5_2,
		z = arg_5_3
	}
	arg_5_0._wayPointEnd = {
		x = arg_5_4,
		y = arg_5_5,
		z = arg_5_6
	}
	arg_5_0._wayPointValue = {
		x = arg_5_4 - arg_5_1,
		y = arg_5_5 - arg_5_2,
		z = arg_5_6 - arg_5_3
	}
end

function var_0_0.setPosDirectly(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._wayPointBegin = nil
	arg_6_0._wayPointValue = nil
	arg_6_0._posX = arg_6_1
	arg_6_0._posY = arg_6_2
	arg_6_0._posZ = arg_6_3

	arg_6_0:updatePrePos()
	arg_6_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_6_0)
end

function var_0_0.setGetTimeFunction(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._getTimeFunction = arg_7_1
	arg_7_0._getTimeObject = arg_7_2
end

function var_0_0.getCurWayPoint(arg_8_0)
	return arg_8_0._curWayPoint
end

function var_0_0.getPos(arg_9_0)
	return arg_9_0._posX, arg_9_0._posY + (arg_9_0._yOffset or 0), arg_9_0._posZ
end

function var_0_0.getPrePos(arg_10_0)
	return arg_10_0.prePosX, arg_10_0.prePosY, arg_10_0.prePosZ
end

function var_0_0.updatePrePos(arg_11_0)
	arg_11_0.prePosX = arg_11_0._posX
	arg_11_0.prePosY = arg_11_0._posY
	arg_11_0.prePosZ = arg_11_0._posZ
end

function var_0_0.onUpdate(arg_12_0)
	if not arg_12_0._wayPointBegin then
		return
	end

	arg_12_0:updatePrePos()

	if arg_12_0._getTimeFunction then
		arg_12_0._currTime = arg_12_0._getTimeFunction(arg_12_0._getTimeObject)
	else
		arg_12_0._currTime = arg_12_0._currTime + Time.deltaTime * arg_12_0._timeScale
	end

	if arg_12_0._currTime >= arg_12_0._duration then
		arg_12_0._posX = arg_12_0._wayPointEnd.x
		arg_12_0._posY = arg_12_0._wayPointEnd.y
		arg_12_0._posZ = arg_12_0._wayPointEnd.z
		arg_12_0._wayPointBegin = nil
		arg_12_0._wayPointEnd = nil
		arg_12_0._wayPointValue = nil

		arg_12_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_12_0)
		arg_12_0:dispatchEvent(UnitMoveEvent.Arrive, arg_12_0)
	else
		if arg_12_0._bezierX and arg_12_0._bezierY then
			local var_12_0 = arg_12_0._currTime / arg_12_0._duration
			local var_12_1 = LuaTween.tween(var_12_0, 0, 1, 1, arg_12_0._easeType)
			local var_12_2 = arg_12_0._bezierX * arg_12_0._wayPointEnd.x + (1 - arg_12_0._bezierX) * arg_12_0._wayPointBegin.x

			arg_12_0._posX = (1 - var_12_1) * (1 - var_12_1) * arg_12_0._wayPointBegin.x + 2 * var_12_1 * (1 - var_12_1) * var_12_2 + var_12_1 * var_12_1 * arg_12_0._wayPointEnd.x
			arg_12_0._posY = (1 - var_12_1) * (1 - var_12_1) * arg_12_0._wayPointBegin.y + 2 * var_12_1 * (1 - var_12_1) * arg_12_0._bezierY + var_12_1 * var_12_1 * arg_12_0._wayPointEnd.y
			arg_12_0._posZ = LuaTween.tween(arg_12_0._currTime, arg_12_0._wayPointBegin.z, arg_12_0._wayPointValue.z, arg_12_0._duration, arg_12_0._easeType)
		else
			arg_12_0._posX = LuaTween.tween(arg_12_0._currTime, arg_12_0._wayPointBegin.x, arg_12_0._wayPointValue.x, arg_12_0._duration, arg_12_0._easeType)
			arg_12_0._posY = LuaTween.tween(arg_12_0._currTime, arg_12_0._wayPointBegin.y, arg_12_0._wayPointValue.y, arg_12_0._duration, arg_12_0._easeType)
			arg_12_0._posZ = LuaTween.tween(arg_12_0._currTime, arg_12_0._wayPointBegin.z, arg_12_0._wayPointValue.z, arg_12_0._duration, arg_12_0._easeType)
		end

		arg_12_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_12_0)
	end
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._animationCurve = nil
end

return var_0_0
