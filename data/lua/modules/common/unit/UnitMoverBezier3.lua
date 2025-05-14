module("modules.common.unit.UnitMoverBezier3", package.seeall)

local var_0_0 = class("UnitMoverBezier3", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._timeScale = 1
	arg_1_0._currTime = 0
	arg_1_0._duration = 0
	arg_1_0._getTimeFunction = nil
	arg_1_0._getTimeObject = nil
	arg_1_0._start = nil

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.setEaseType(arg_2_0, arg_2_1)
	arg_2_0._easeType = arg_2_1 or EaseType.Linear
end

function var_0_0.setTimeScale(arg_3_0, arg_3_1)
	arg_3_0._timeScale = arg_3_1
end

function var_0_0.simpleMove(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0:setPosDirectly(arg_4_1.x, arg_4_1.y, arg_4_1.z)

	arg_4_0.p1 = arg_4_1
	arg_4_0.p2 = arg_4_2
	arg_4_0.p3 = arg_4_3
	arg_4_0.p4 = arg_4_4
	arg_4_0.startPos = arg_4_1
	arg_4_0.endPos = arg_4_4
	arg_4_0._duration = arg_4_5
	arg_4_0._currTime = 0
	arg_4_0._start = true
end

function var_0_0.setPosDirectly(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._posX = arg_5_1
	arg_5_0._posY = arg_5_2
	arg_5_0._posZ = arg_5_3

	arg_5_0:updatePrePos()
	arg_5_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_5_0)
end

function var_0_0.updatePrePos(arg_6_0)
	arg_6_0.prePosX = arg_6_0._posX
	arg_6_0.prePosY = arg_6_0._posY
	arg_6_0.prePosZ = arg_6_0._posZ
end

function var_0_0.setGetTimeFunction(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._getTimeFunction = arg_7_1
	arg_7_0._getTimeObject = arg_7_2
end

function var_0_0.getPos(arg_8_0)
	return arg_8_0._posX, arg_8_0._posY, arg_8_0._posZ
end

function var_0_0.getPrePos(arg_9_0)
	return arg_9_0.prePosX, arg_9_0.prePosY, arg_9_0.prePosZ
end

function var_0_0.onUpdate(arg_10_0)
	if not arg_10_0._start then
		return
	end

	arg_10_0:updatePrePos()

	if arg_10_0._getTimeFunction then
		arg_10_0._currTime = arg_10_0._getTimeFunction(arg_10_0._getTimeObject)
	else
		arg_10_0._currTime = arg_10_0._currTime + Time.deltaTime * arg_10_0._timeScale
	end

	if arg_10_0._currTime >= arg_10_0._duration then
		arg_10_0._posX = arg_10_0.endPos.x
		arg_10_0._posY = arg_10_0.endPos.y
		arg_10_0._posZ = arg_10_0.endPos.z

		arg_10_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_10_0)
		arg_10_0:dispatchEvent(UnitMoveEvent.Arrive, arg_10_0)

		arg_10_0._start = nil
	else
		local var_10_0 = arg_10_0._currTime / arg_10_0._duration
		local var_10_1 = LuaTween.tween(var_10_0, 0, 1, 1, arg_10_0._easeType)

		arg_10_0._posX = arg_10_0:calculateValue(var_10_1, arg_10_0.p1.x, arg_10_0.p2.x, arg_10_0.p3.x, arg_10_0.p4.x)
		arg_10_0._posY = arg_10_0:calculateValue(var_10_1, arg_10_0.p1.y, arg_10_0.p2.y, arg_10_0.p3.y, arg_10_0.p4.y)
		arg_10_0._posZ = arg_10_0:calculateValue(var_10_1, arg_10_0.p1.z, arg_10_0.p2.z, arg_10_0.p3.z, arg_10_0.p4.z)

		arg_10_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_10_0)
	end
end

function var_0_0.calculateValue(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = (1 - arg_11_1) * (1 - arg_11_1) * (1 - arg_11_1) * arg_11_2
	local var_11_1 = 3 * arg_11_1 * (1 - arg_11_1) * (1 - arg_11_1) * arg_11_3
	local var_11_2 = 3 * arg_11_1 * arg_11_1 * (1 - arg_11_1) * arg_11_4
	local var_11_3 = arg_11_1 * arg_11_1 * arg_11_1 * arg_11_5

	return var_11_0 + var_11_1 + var_11_2 + var_11_3
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._start = nil
	arg_12_0._animationCurve = nil
end

return var_0_0
